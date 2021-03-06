
user_account 'peterb' do
  comment 'Peter Burkholder'
  uid 2000
  ssh_keys [
    'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOFZ2MgcCFjQvmJaRBfnlRQq8EEC68vJ9Xyi6qD1ABdRrez4L2vk/+e7LuzU3418UEtfnJWx/s9lc5p0vILcdFOvbbiP+SYZ8vd5btAfkmnUW4ZFeaBRjmFRjvNiMvdXyGpUb4/168yq1k/5Rqy7ZH6Ly3NHvS8IYgDXlefg0ZitHi4tO1qJsdCHwc0TxFZBBKjkZVhiJHNJCG9X2u8kO+P/dBtRNwHUrC5o4F0yToWeeYzbyJ4LpZzrF23Kw65s/djFNug81VQLKOCsY52dZrU6lPJHEoGJwm3onkWpLYoEye2vpRaBp2OtTTtJqj5G/23VojF/LwvbATLrSr49Q1 pburkholder'
  ]
  password '$1$oF3uPnkd$XOoB.I6tR8OnE9ntfSGeG.'
end

user_account 'alpha' do
  comment 'Alpha Devop'
  uid 2001
  password '$1$s5i2dCBE$KSRrHpufVP0GrJhczf11O0'
end

user_account 'bravo' do
  comment 'Bravo Devop'
  uid 2002
  password '$1$s5i2dCBE$KSRrHpufVP0GrJhczf11O0'
end

if ::File.exists?('/home/ubuntu')
  user_account 'ubuntu' do
    action :lock
  end
end

group 'devops' do
  gid 1999
  members ['alpha', 'bravo', 'peterb']
end

%w(alpha bravo peterb).each do |user|
  directory "/home/#{user}/.git_templates/hooks" do
    owner user
    group user
    recursive true
  end

  template "/home/#{user}/.gitconfig" do
    owner user
    group user
    mode "0644"
    source "gitconfig"
  end

  template "/home/#{user}/.git_templates/hooks/pre-commit" do
    owner user
    group user
    mode "0755"
    source 'pre-commit'
  end
end
