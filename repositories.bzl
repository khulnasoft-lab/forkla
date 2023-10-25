load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//third_party:bazel.bzl", "bazel_sha256", "bazel_version")
load("//third_party:bazel_buildtools.bzl", "buildtools_sha256", "buildtools_version")
load("//third_party:bazel_skylib.bzl", "skylib_sha256", "skylib_version")

def forkla_repositories():
    RULES_JVM_EXTERNAL_TAG = "4.2"

    RULES_JVM_EXTERNAL_SHA = "cd1a77b7b02e8e008439ca76fd34f5b07aecb8c752961f9640dea15e9e5ba1ca"

    maybe(
        http_archive,
        name = "platforms",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/platforms/releases/download/0.0.8/platforms-0.0.8.tar.gz",
            "https://github.com/bazelbuild/platforms/releases/download/0.0.8/platforms-0.0.8.tar.gz",
        ],
        sha256 = "8150406605389ececb6da07cbcb509d5637a3ab9a24bc69b1101531367d89d74",
    )

    maybe(
        http_archive,
        name = "rules_jvm_external",
        sha256 = RULES_JVM_EXTERNAL_SHA,
        strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
        url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "io_bazel",
        sha256 = bazel_sha256,
        strip_prefix = "bazel-" + bazel_version,
        url = "https://github.com/bazelbuild/bazel/archive/" + bazel_version + ".zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    # Buildifier and friends:
    maybe(
        http_archive,
        name = "buildtools",
        sha256 = buildtools_sha256,
        strip_prefix = "buildtools-" + buildtools_version,
        url = "https://github.com/bazelbuild/buildtools/archive/" + buildtools_version + ".zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    # Additional bazel rules:
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = skylib_sha256,
        strip_prefix = "bazel-skylib-" + skylib_version,
        url = "https://github.com/bazelbuild/bazel-skylib/archive/" + skylib_version + ".zip",
    )

    EXPORT_WORKSPACE_IN_BUILD_FILE = [
        "test -f BUILD && chmod u+w BUILD || true",
        "echo >> BUILD",
        "echo 'exports_files([\"WORKSPACE\"], visibility = [\"//visibility:public\"])' >> BUILD",
    ]

    EXPORT_WORKSPACE_IN_BUILD_FILE_WIN = [
        "Add-Content -Path BUILD -Value \"`nexports_files([`\"WORKSPACE`\"], visibility = [`\"//visibility:public`\"])`n\" -Force",
    ]

    # Stuff used by Bazel Starlark syntax package transitively:
    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "com_google_protobuf",
        patch_args = ["-p1"],
        patches = ["@io_bazel//third_party/protobuf:21.7.patch"],
        patch_cmds = EXPORT_WORKSPACE_IN_BUILD_FILE,
        patch_cmds_win = EXPORT_WORKSPACE_IN_BUILD_FILE_WIN,
        sha256 = "616bb3536ac1fff3fb1a141450fa28b875e985712170ea7f1bfe5e5fc41e2cd8",
        strip_prefix = "protobuf-24.4",
        urls = [
            "https://mirror.bazel.build/github.com/protocolbuffers/protobuf/archive/v24.4.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v24.4.tar.gz",
        ],
    )

    # Stuff used by Buildifier transitively:
    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "dd926a88a564a9246713a9c00b35315f54cbd46b31a26d5d8fb264c07045f05d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
        ],
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_pkg",
        sha256 = "8c20f74bca25d2d442b327ae26768c02cf3c99e93fad0381f32be9aab1967675",
        url = "https://github.com/bazelbuild/rules_pkg/releases/download/0.8.1/rules_pkg-0.8.1.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_java",
        sha256 = "220b87d8cfabd22d1c6d8e3cdb4249abd4c93dcc152e0667db061fb1b957ee68",
        url = "https://github.com/bazelbuild/rules_java/releases/download/0.1.1/rules_java-0.1.1.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "71d3ae8f4a2577441b3f300f2f025a390ef964b9a68f32f9fe63f808f2bee9b8",
        strip_prefix = "rules_python-5b082bb02b048a4b630843b6b582bd6f40d38b9e",
        url = "https://github.com/bazelbuild/rules_python/archive/5b082bb02b048a4b630843b6b582bd6f40d38b9e.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_cc",
        sha256 = "faa25a149f46077e7eca2637744f494e53a29fe3814bfe240a2ce37115f6e04d",
        strip_prefix = "rules_cc-ea5c5422a6b9e79e6432de3b2b29bbd84eb41081",
        url = "https://github.com/bazelbuild/rules_cc/archive/ea5c5422a6b9e79e6432de3b2b29bbd84eb41081.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_license",
        sha256 = "00ccc0df21312c127ac4b12880ab0f9a26c1cff99442dc6c5a331750360de3c3",
        url = "https://mirror.bazel.build/github.com/bazelbuild/rules_license/releases/download/0.0.3/rules_license-0.0.3.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "7d05492099a4359a6006d1b89284d34b76390c3b67d08e30840299b045838e2d",
        strip_prefix = "rules_proto-9cd4f8f1ede19d81c6d48910429fe96776e567b1",
        url = "https://github.com/bazelbuild/rules_proto/archive/9cd4f8f1ede19d81c6d48910429fe96776e567b1.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "ecba0f04f96b4960a5b250c8e8eeec42281035970aa8852dda73098274d14a1d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
        ],
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "JCommander",
        sha256 = "e7ed3cf09f43d0d0a083f1b3243c6d1b45139a84a61c6356504f9b7aa14554fc",
        urls = [
            "https://github.com/cbeust/jcommander/archive/05254453c0a824f719bd72dac66fa686525752a5.zip",
        ],
        build_file = Label("//external/third_party:jcommander.BUILD"),
    )
