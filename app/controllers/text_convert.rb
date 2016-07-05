puts '执行脚本'

require 'csv'
require 'json'

def finish
  exit 0
end

def randstr(length=8)
  base = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  size = base.size
  re = '' << base[rand(size-10)]
  (length - 1).times {
    re << base[rand(size)]
  }
  re
end

def ABCD_TO_0123(str)
  str.ord-65
end


print "输入题型( A:单选题，B:多选题，C:判断题): "
type = gets
case type
  when "A\n" then
    puts "将要制作单选题json文件"
    $type = 'single_choice'
  when "B\n" then
    puts "将要制作多选题json文件"
    $type = 'multi_choice'
  when "C\n" then
    puts "将要制作判断题json文件"
    $type = 'bool'
  else
    puts "输入错误 程序结束"
    finish();
end


def transfer_to_json(file_name)
  json_strs = {:question=>[]}
  CSV.open(file_name,"r").each do |csv|
    hash={}
    # 做题型判断
    match = /[0-9]+/.match(csv[0])
    if !match.nil?&&match[0].length == csv[0].length
      case $type
        when "multi_choice" then
          hash[:kind] = $type
          hash[:content] = csv[1]
          hash[:answer]={}
          hash[:answer][:choices]=[]

          # TODO  有的有ef
          for i in 3..8 do
            if !csv[i].nil?
              hash[:answer][:choices].push({:id => randstr,:text => csv[i]})
            end
          end
          # # answer->id
          hash[:answer][:corrects]=[]
          for m in 0..csv[2].length-1 do
            hash[:answer][:corrects].push(hash[:answer][:choices][ABCD_TO_0123(csv[2][m])][:id])
          end         
        when "single_choice" then
          hash[:kind] = $type
          hash[:content] = csv[1]
          hash[:answer]={}
          hash[:answer][:choices]=[]
          for i in 3..6 do
            hash[:answer][:choices].push({:id => randstr,:text => csv[i]})
          end
          # answer->id
          hash[:answer][:correct] = hash[:answer][:choices][ABCD_TO_0123(csv[2])][:id]
        when "bool" then
          hash[:kind] = $type
          hash[:content] = csv[1]
          if csv[2] == "√"
            hash[:answer] = true
          end
          if csv[2] == "×"
             hash[:answer] = false
          end
      end
      json_strs[:question].push(hash)
    end
  end

# 写入yml/json文件
file = File.new(File.join("./json","#{file_name}.json"),"w+")
file.puts(JSON.generate(json_strs))
end

print "输入工程主目录下需要转换的文件名\n"
print "格式 xxxx.csv  :"
file_name = gets
if File::exists?(file_name.gsub(/\n/,""))
  transfer_to_json (file_name.gsub(/\n/,""));
else
  puts "找不到文件 程序结束"
  finish();
end