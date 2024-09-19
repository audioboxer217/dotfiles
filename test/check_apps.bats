#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

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
