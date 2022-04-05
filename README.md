# Nginx/Auth0 Proxy

A simple Dockerized authentication proxy for Jupyterlab.

Jupyterlab is deployed by the Control Panel. When deployed the pod looks like the image below, with Jupyterlab protected from the internet by this proxy.

![Diagram explaining the structure where the proxy authenticates against Auth0, and then allows authenticated access to the jupyterhub image](docs/images/jupyterlab-pod.drawio-s.png "How the proxy is used")

The authentication is done using an OIDC call to Auth0, the call is written in lua.

N.B. There may in future be a better solution, however at time of implementation, lua was the nginx community recommended solution for this authentication flow.
## Usage

All interactions are performed via the `Makefile`.

| Makefile command | Description |
| ---------------- | ----------- |
| clean | stop & destroy cont. |
| pull | pull the latest img (unused) |
| push | push the image to repo (gha-only) |
| build | build the proxy image |
| up | start the proxy and jupyter in daemon mode |
| logs | see the logs |
| integration | just run the tests (for gha) |
| test | run the test process inc. start and cleanup |
### Running the Application Locally

Ensure you have the expected environment variables (see below) in a `.envrc`
file. Then run `direnv allow` to set these for work done in the project's home
directory.

Run `make build` then `make up` to start the proxy and Jupyter. Once up, you'll
find it at [http://localhost/](http://localhost/).

To view logs, `make logs`, to attach to the proxy's shell, `make enter`.

To stop the proxy, `make clean`.

## Environment Variables

| Environment Variable | Description                                          |
| -------------------- | -----------------------------------------------------|
| APP_HOST             | The hostname of the proxied app (e.g. rstudio)       |
| APP_PORT             | Port on which the proxied app is listening (eg 8787) |
| USERNAME             | GitHub username of the person whose instance this is |
| LOGOUT_URL           | To where users should be directed on logout          |
| AUTH0_TENANT_DOMAIN  | From Auth0, the context in which users authenticate  |
| AUTH0_CLIENT_ID      | From Auth0, identifies the app in the tenant         |
| AUTH0_CLIENT_SECRET  | From Auth0, for the referenced app in the tenant     |
| REDIRECT_DOMAIN      | The root domain name that AP tools are running on    |

## Releasing

The `Prep Tags` step in the GitHub worklfow changes the pushed tag based on the
GitHub trigger.

- If tags have been pushed, use that tag as the version
- If the default branch is pushed to, tag the image as edge
- If a PR is pushed, tag as per the PR number
- Anything other than the above scenarios: use the Git SHA
