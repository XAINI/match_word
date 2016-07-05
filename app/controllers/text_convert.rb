require 'json'

def finish
  exit 0
end

print "输入题型( A:单选题，B:多选题):"
type = gets
case type
  when "A\n" then
    puts "将要制作单选题json文件"
    $type = 'single_choice'
  when "B\n" then
    puts "将要制作多选题json文件"
    $type = 'multi_choice'
  else
    puts "输入错误 程序结束"
    finish()
end

print "输入工程主目录下需要转换的文件名\n"
print "格式 xxxx.csv  :"
file_name = gets
if File::exists?(file_name.gsub(/\n/,""))
  transfer_to_json (file_name.gsub(/\n/,""))
else
  puts "找不到文件 程序结束"
  finish()
end

def transfer_to_json
  json_str = {question: []}
  JSON.open(file_name,"r").each do |json|
    p json
  end
end