# webページに任意の文字を出力させる
# @param [String] 表示させたい文章
# @return [nil] 引数が Date 型以外の場合は nil
def print_test(string)
  print("Hello, ", string , ".\n")
end

print "Content-Type: text/html\n\n";
print_test("heyheytower")
