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
  args = "test --trace"
  needs = ["mix deps.get"]
}

action "mix format" {
  uses = "jclem/actions/mix@master"
  args = "format --check-formatted"
}
