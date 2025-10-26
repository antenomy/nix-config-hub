{
  pkgs, 
  ... 
}:
{
  environment.systemPackages = with pkgs; [
    # Basic
    vim
    cloudflared
    just
    neofetch
    detect-secrets
    wakeonlan
  ];
}