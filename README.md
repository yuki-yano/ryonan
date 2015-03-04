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
sample=Sample
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
    sample (Default:Sample) ->
    dir -> dir1
    method_name -> method_name1
I, [2015-03-05T06:58:26.892198 #50253]  INFO -- : cp -r ./template1/.template ./template1/test_template
I, [2015-03-05T06:58:26.894241 #50253]  INFO -- : rm ./template1/test_template/.config
I, [2015-03-05T06:58:26.894626 #50253]  INFO -- : mv ./template1/test_template/__sample__.rb.erb ./template1/test_template/Sample.rb.erb
I, [2015-03-05T06:58:26.895136 #50253]  INFO -- : mv ./template1/test_template/__dir__ ./template1/test_template/dir1
I, [2015-03-05T06:58:26.897876 #50253]  INFO -- : render_erb ./template1/test_template/Sample.rb.erb to ./template1/test_template/Sample.rb
I, [2015-03-05T06:58:26.898089 #50253]  INFO -- : rm ./template1/test_template/Sample.rb.erb

$ tree template1/test_template/
template1/test_template/
├── Sample.rb
├── dir1
│   └── sample2.rb
└── dir2

$ cat template1/test_template/Sample.rb
class Sample
  def method1; end
  def method_name1; end
en

```

## Template candidate

```
$ mkdir directory

$ cp -r template1/ directory/template2

$ ryonan
Template List
    [0] : './directory/template2'
    [1] : './template1'

Select Template[*] -> 0
Input the destination directory name -> test_template2
Set the value to the variable in the template
    sample (Default:Sample) -> sample
    dir -> dir
    method_name -> method_name
I, [2015-03-05T07:00:54.992676 #51451]  INFO -- : cp -r ./directory/template2/.template ./directory/template2/test_template2
I, [2015-03-05T07:00:54.993609 #51451]  INFO -- : rm ./directory/template2/test_template2/.config
I, [2015-03-05T07:00:54.994570 #51451]  INFO -- : mv ./directory/template2/test_template2/__sample__.rb.erb ./directory/template2/test_template2/sample.rb.erb
I, [2015-03-05T07:00:54.997861 #51451]  INFO -- : mv ./directory/template2/test_template2/__dir__ ./directory/template2/test_template2/dir
I, [2015-03-05T07:00:54.998434 #51451]  INFO -- : render_erb ./directory/template2/test_template2/sample.rb.erb to ./directory/template2/test_template2/sample.rb
I, [2015-03-05T07:00:54.998616 #51451]  INFO -- : rm ./directory/template2/test_template2/sample.rb.erb

$ tree directory/template2/test_template2/
directory/template2/test_template2/
├── dir
│   └── sample2.rb
├── dir2
└── sample.rb
```
