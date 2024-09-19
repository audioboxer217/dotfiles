#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
load "${HOME}/.bash_functions"

@test "weather function" {
	run wttr
	assert_success
}

@test "news function" {
	run news
	assert_success
}

@test "git_status function" {
	run git_status
	assert_success
}
