#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "bat" {
    run bat -h
    assert_success
}

@test "eza" {
    run eza
    assert_success
}

@test "prettyping" {
    run prettyping -h
    assert_success
}
