MRuby::Build.new do |conf|
  toolchain :gcc
  enable_debug
  conf.gembox 'default'

  ## KVS mrbgems
  # C and/or Ruby
  conf.gem :git => 'https://github.com/udzura/mruby-etcd.git'
  conf.gem :git => 'https://github.com/Asmod4n/mruby-lmdb.git'
  conf.gem :git => 'https://github.com/matsumotory/mruby-redis.git'
  # C++
  #enable_cxx_abi
  #conf.gem :git => 'https://github.com/syucream/mruby-k2hash.git'

  conf.gem '../mruby/mrbgems/mruby-neco'
end
