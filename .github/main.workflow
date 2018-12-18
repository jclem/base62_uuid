workflow "Run tests" {
  on = "push"
  resolves = ["mix test"]
}

action "mix deps.get" {
  uses = "jclem/actions/mix@master"
  args = "deps.get"
}

action "mix test" {
  uses = "jclem/actions/mix@master"
  args = "test"
  needs = ["mix deps.get"]
}
