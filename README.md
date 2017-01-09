# mruby-neco
NoSQL elastic command organizer :cat:

# example

```ruby
# Add NoSQL drivers to Neco org to use unified I/F
org = Neco::KvsOrg.new
org.add_member(:etcd, {:url => 'http://127.0.0.1:2379/v2'})
org.add_member(:lmdb, {:path => '/tmp/tmp.lmdb', :options => {:flags => MDB::NOSUBDIR}})
org.add_member(:redis, {:host => 'localhost', :port => 6379})
org.add_member(:k2hash, {:path => '/tmp/tmp.k2hash', :options => {:mode => 0666, :flags => K2Hash::NEWDB}})

# put to each NoSQL
org.put_to :etcd, 'key', 'etcd'
org.put_to :lmdb, 'key', 'lmdb'
org.put_to :redis, 'key', 'redis'
org.put_to :k2hash, 'key', 'k2hash'

# get a value from each NoSQL
p org.get_from :redis, 'key' #=> {:redis=>"redis"}

# put to all NoSQL's
org.put_to_all 'key', 'value'

# get values from all NoSQL's
p org.get_from_all 'key' #=> {:etcd=>"value", :lmdb=>"value", :redis=>"value", :k2hash=>"value"}

# pass a block to a NoSQL driver
org.each_for(:redis) do |key, value|
  puts "key: #{key}, value: #{value}"
end

# pass a block to all NoSQL driver's
org.each do |key, value|
  puts "key: #{key}, value: #{value}"
end
```
