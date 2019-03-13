workflow "Run tests" {
    on = "push"
    resolves = ["Test", "Check Formatting"]
}

action "Get Deps" {
    uses = "jclem/action-mix/deps.get@v1.3.1"
}

action "Test" {
    uses = "jclem/action-mix@v1.3.1"
    args = "coveralls.post --trace -n \"github-actions\" -b \"$GITHUB_REF\" -s \"$GITHUB_SHA\" -c \"$GITHUB_ACTOR\""
    needs = "Get Deps"
    env = {MIX_ENV = "test"}
    secrets = ["COVERALLS_REPO_TOKEN"]
}

action "Check Formatting" {
    uses = "jclem/action-mix@v1.3.1"
    needs = "Get Deps"
    args = "format --check-formatted"
}
