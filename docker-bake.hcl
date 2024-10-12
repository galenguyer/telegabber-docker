variable "CORE_COUNT" { default = "1" }
variable "REGISTRY" { default = "local" }

group "default" {
    targets = ["telegabber"]
}

target "alpine-mainline" {
    args = {
        CORE_COUNT="${CORE_COUNT}"
    }
    platforms = ["linux/amd64", "linux/arm64"]
    tags = [
        "${REGISTRY}/telegabber:latest"
    ]
}
