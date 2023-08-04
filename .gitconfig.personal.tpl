
[user]
  email = john.smith@example.com
  name = John Smith


# 1Password commit signing
[user]
  signingkey = ssh-ed25519 AAAA......

[gpg]
  format = ssh

[gpg "ssh"]
  program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

[commit]
  gpgsign = true
