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

$ ryonan
Templete List
    [0] : './template1'

Select Templete[*] -> 0
Input the destination directory name -> test_templete
Set the value to the variable in the template
    sample -> sample1
    dir -> dir1
    method_name -> method_name1
I, [2015-03-04T02:16:18.931974 #75803]  INFO -- : cp -r ./template1/.template ./template1/test_templete
I, [2015-03-04T02:16:18.933247 #75803]  INFO -- : mv ./template1/test_templete/__sample__.rb.erb ./template1/test_templete/sample1.rb.erb
I, [2015-03-04T02:16:18.933645 #75803]  INFO -- : mv ./template1/test_templete/__dir__ ./template1/test_templete/dir1
I, [2015-03-04T02:16:18.934294 #75803]  INFO -- : render_erb ./template1/test_templete/sample1.rb.erb to ./template1/test_templete/sample1.rb
I, [2015-03-04T02:16:18.934489 #75803]  INFO -- : rm ./template1/test_templete/sample1.rb.erb

$ tree template1/test_templete/
template1/test_templete/
├── dir1
│   └── sample2.rb
├── dir2
└── sample1.rb

$ cat template1/test_templete/sample1.rb
class sample1
  def method1; end
  def method_name1; end
end
```

## Template candidate

```
$ mkdir directory

$ cp -r template1 directory/templete2

$ ryonan
Templete List
    [0] : './directory/templete2'
    [1] : './template1'

Select Templete[*] -> 0
Input the destination directory name -> test_templete2
Set the value to the variable in the template
    sample -> sample2
    dir -> dir2
    method_name -> method_name2
I, [2015-03-04T02:20:15.923823 #77485]  INFO -- : cp -r ./directory/templete2/.template ./directory/templete2/test_templete2
I, [2015-03-04T02:20:15.925812 #77485]  INFO -- : mv ./directory/templete2/test_templete2/__sample__.rb.erb ./directory/templete2/test_templete2/sample2.rb.erb
I, [2015-03-04T02:20:15.926232 #77485]  INFO -- : mv ./directory/templete2/test_templete2/__dir__ ./directory/templete2/test_templete2/dir2
I, [2015-03-04T02:20:15.926528 #77485]  INFO -- : mv ./directory/templete2/test_templete2/dir2/__dir__ ./directory/templete2/test_templete2/dir2/dir2
I, [2015-03-04T02:20:15.927149 #77485]  INFO -- : render_erb ./directory/templete2/test_templete2/sample2.rb.erb to ./directory/templete2/test_templete2/sample2.rb
I, [2015-03-04T02:20:15.927306 #77485]  INFO -- : rm ./directory/templete2/test_templete2/sample2.rb.erb

$ tree directory/templete2/
directory/templete2/
└── test_templete2
    ├── dir2
    │   └── dir2
    │       └── sample2.rb
    └── sample2.rb
```
