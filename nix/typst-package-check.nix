{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  stdenv,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "typst-package-check";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "typst";
    repo = "package-check";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/JsXhqwqRyXnZDxZ8qnavns9VO81Ss2tmnl5uAj9A0Q=";
  };

  cargoHash = "sha256-7lpmevoAZ0pRTdpSx17IhhwdqhcVVsvoqHUci+Makf8=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [ openssl ];

  # the test suite reaches out to Typst Universe
  doCheck = false;

  meta = {
    description = "Checker for packages submitted to Typst Universe";
    homepage = "https://github.com/typst/package-check";
    license = lib.licenses.asl20;
    mainProgram = "typst-package-check";
  };
})
