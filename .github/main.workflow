workflow "Run tests" {
  on = "push"
  resolves = [
    "mix test",
    "mix format",
  ]
}

action "mix deps.get" {
  uses = "jclem/actions/mix@master"
  args = "deps.get"
}

action "mix test" {
  uses = "jclem/actions/mix@master"
  args = "coveralls.post --trace -n \"github-actions\" -b \"$GITHUB_REF\" -s \"$GITHUB_SHA\" -c \"$GITHUB_ACTOR\""
  needs = ["mix deps.get"]
  env = {
    MIX_ENV = "test"
  }
  secrets = ["COVERALLS_REPO_TOKEN"]
}

action "mix format" {
  uses = "jclem/actions/mix@master"
  args = "format --check-formatted"
}
