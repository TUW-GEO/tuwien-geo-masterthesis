{
  lib,
  buildGoModule,
  go_1_27,
  fetchFromGitHub,
  git,
  stdenv,
}:

(buildGoModule.override { go = go_1_27; }) (finalAttrs: {
  pname = "gotpm";
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "npikall";
    repo = "gotpm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-sXRqRwoqACn/EYiIWMFzho7DpN7OAD7KSB1JXvxVlVk=";
  };

  # upstream commits its vendor/ directory
  vendorHash = null;

  # mirrors upstream's .goreleaser.yaml so `gotpm --version` is accurate
  ldflags = [
    "-s"
    "-w"
    "-X github.com/npikall/gotpm/cmd.gitTag=v${finalAttrs.version}"
    "-X github.com/npikall/gotpm/cmd.buildOS=${stdenv.hostPlatform.parsed.kernel.name}"
    "-X github.com/npikall/gotpm/cmd.buildARCH=${stdenv.hostPlatform.parsed.cpu.name}"
    "-X github.com/npikall/gotpm/cmd.installer=Nix"
  ];

  # the publish command's tests shell out to git
  nativeCheckInputs = [ git ];

  meta = {
    description = "Typst package manager";
    homepage = "https://github.com/npikall/gotpm";
    license = lib.licenses.mit;
    mainProgram = "gotpm";
  };
})
