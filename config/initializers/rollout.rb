require 'redis'
require 'rollout'

$redis = Redis.new
$rollout = Rollout.new($redis)
