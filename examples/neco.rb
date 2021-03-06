org = Neco::KvsOrg.new

org.add_member(:etcd, {:url => 'http://127.0.0.1:2379/v2'})
org.add_member(:lmdb, {:path => '/tmp/tmp.lmdb', :options => {:flags => MDB::NOSUBDIR}})
org.add_member(:redis, {:host => 'localhost', :port => 6379})
org.add_member(:k2hash, {:path => '/tmp/tmp.k2hash', :options => {:mode => 0666, :flags => K2Hash::NEWDB}})

org.put_to :etcd, 'key', 'etcd'
org.put_to :lmdb, 'key', 'lmdb'
org.put_to :redis, 'key', 'redis'
org.put_to :k2hash, 'key', 'k2hash'
p org.get_from_all 'key'

org.put_to_all 'key', 'value'
p org.get_from_all 'key'

puts 'each_for :redis'
org.each_for(:redis) do |key, value|
  puts "key: #{key}, value: #{value}"
end

puts 'each'
org.each do |key, value|
  puts "key: #{key}, value: #{value}"
end
