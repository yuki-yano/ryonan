# Ryonan

Ryonan is a tool to make simple skeleton.

It make from template directory and erb, and interactively operation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ryonan'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ryonan

## Usage

Create a directory named `.template` and file named `.template/.config`.

`.template` is replicated and `.config` is used to set variables in interactive command.

- `variable_name = 'value'`
    - Directory `__variable_name__` > `value`
    - File `__variable_name__.rb` > `value.rb`
    - Erb File `__variable_name__.rb.erb` > `value.rb` and render erb

```
$ tree -a
.
└── template1
    └── .template
        ├── .config
        ├── __dir__
        │   └── sample2.rb
        ├── __sample__.rb.erb
        └── dir2

$ cat template1/.template/.config
sample
dir
method_name

$ cat template1/.template/__sample__.rb.erb
class <%= sample %>
  def method1; end
  def <%= method_name %>; end
end

$ ryonan
Template List
    [0] : './template1'

Select Template[*] -> 0
Input the destination directory name -> test_template
Set the value to the variable in the template
    sample -> sample1
    dir -> dir1
    method_name -> method_name1
I, [2015-03-04T02:16:18.931974 #75803]  INFO -- : cp -r ./template1/.template ./template1/test_template
I, [2015-03-04T02:16:18.933247 #75803]  INFO -- : mv ./template1/test_template/__sample__.rb.erb ./template1/test_template/sample1.rb.erb
I, [2015-03-04T02:16:18.933645 #75803]  INFO -- : mv ./template1/test_template/__dir__ ./template1/test_template/dir1
I, [2015-03-04T02:16:18.934294 #75803]  INFO -- : render_erb ./template1/test_template/sample1.rb.erb to ./template1/test_template/sample1.rb
I, [2015-03-04T02:16:18.934489 #75803]  INFO -- : rm ./template1/test_template/sample1.rb.erb

$ tree template1/test_template/
template1/test_template/
├── dir1
│   └── sample2.rb
├── dir2
└── sample1.rb

$ cat template1/test_template/sample1.rb
class sample1
  def method1; end
  def method_name1; end
end
```

## Template candidate

```
$ mkdir directory

$ cp -r template1 directory/template2

$ ryonan
Template List
    [0] : './directory/template2'
    [1] : './template1'

Select Template[*] -> 0
Input the destination directory name -> test_template2
Set the value to the variable in the template
    sample -> sample
    dir -> dir
    method_name -> method_name
I, [2015-03-04T02:20:15.923823 #77485]  INFO -- : cp -r ./directory/template2/.template ./directory/template2/test_template2
I, [2015-03-04T02:20:15.925812 #77485]  INFO -- : mv ./directory/template2/test_template2/__sample__.rb.erb ./directory/template2/test_template2/sample.rb.erb
I, [2015-03-04T02:20:15.926232 #77485]  INFO -- : mv ./directory/template2/test_template2/__dir__ ./directory/template2/test_template2/dir
I, [2015-03-04T02:20:15.927149 #77485]  INFO -- : render_erb ./directory/template2/test_template2/sample.rb.erb to ./directory/template2/test_template2/sample.rb
I, [2015-03-04T02:20:15.927306 #77485]  INFO -- : rm ./directory/template2/test_template2/sample.rb.erb

$ tree directory/templete2/test_templete2/
directory/templete2/test_templete2/
├── dir
│   └── sample2.rb
├── dir2
└── sample.rb
```
