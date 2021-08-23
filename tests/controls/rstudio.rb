title 'RStudio'

options = {
  enable_remote_worker: true,
  headers: { 'User-Agent' => 'Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20100101 Firefox/10.0' },
  ssl_verify: false
}

control 'RStudio should load' do
  impact 'high'
  title 'RStudio should be available behind the proxy'
  desc 'The proxy should redirect to the Auth0 login page and give a 302.'
  tag 'rstudio'
  tag 'proxy'

  describe http('http://nginx-proxy:3000/', options) do
    its('status') { should cmp 302}
  end
end
