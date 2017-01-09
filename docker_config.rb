MRuby::Build.new do |conf|
  toolchain :gcc

  enable_debug
  conf.enable_bintest
  conf.enable_test

  # to use k2hash
  conf.linker.flags_after_libraries << "-lstdc++ -ldl -lcrypto -lpthread -lfullock"

  conf.gembox 'default'
  conf.gem :git => 'https://github.com/udzura/mruby-etcd.git'
  conf.gem :git => 'https://github.com/Asmod4n/mruby-lmdb.git'
  conf.gem :git => 'https://github.com/matsumotory/mruby-redis.git'
  conf.gem :git => 'https://github.com/syucream/mruby-k2hash.git'
end
