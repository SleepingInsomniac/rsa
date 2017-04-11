#!/usr/bin/env ruby

def random_word
  File.open '/usr/share/dict/words', 'r' do |file|
    file.seek(rand(0..file.size))
    file.seek(-2, IO::SEEK_CUR) until file.tell == 0 || file.getc == "\n"
    file.readline
  end
end

10.times do
  puts random_word
end
