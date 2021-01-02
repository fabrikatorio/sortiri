# Description

Sortiri is a clean and lightweight solution for making ActiveRecord::Base objects sortable.

## Getting started

Sortiri is supported for ActiveRecord 4.2+ on Ruby 2.6.0 and later.

In your Gemfile, for the last officially released gem:

```ruby
gem 'sortiri'
```

## Usage

To add Sortiri to an ActiveRecord::Base object, simply include the Sortiri module.

```ruby
class User < ActiveRecord::Base
  include Sortiri::Model
end
```

### Ascending

Sorting is ascending by default and can be reversed by adding a hyphen (-) to the start of the property name.

```ruby
# GET /users?sort=name

class User < ActiveRecord::Base
  include Sortiri::Model

  sortable against: %i[name age weight], default_sort: 'age'
end

# users will be sorted by name and ascending (A -> Z)
```

### Descending

To sort by descending, simply add a hypen (-) to the start of the property name.

```ruby
# GET /users?sort=-name

class User < ActiveRecord::Base
  include Sortiri::Model

  sortable against: %i[name age weight], default_sort: 'age'
end

# users will be sorted by name and descending (Z -> A)
```

### Default sort option

It is mandatory to provide a default sort option for the model. If nothing is passed, the default sort option will be applied.

```ruby
# GET /users

class User < ActiveRecord::Base
  include Sortiri::Model

  sortable against: %i[name age weight], default_sort: '-age'
end

# users will be sorted by age and descending
```

### Sorting through associations

It is possible to sort columns on associated models.

You can pass a Hash into the :associated_against option to set up sorting through associations. The keys are the names of the associations and the value works just like an :against option for the other model. Right now, sorting deeper than one association away is not supported.

```ruby
class Company < ActiveRecord::Base
  has_many :users
end

# GET /users?sort=-company.name

class User < ActiveRecord::Base
  include Sortiri::Model

  belongs_to :company

  sortable against: %i[name age weight], associated_against: { company: [:name] }, default_sort: '-age'
end

# users will be sorted by their companies name and descending (Z -> A)
```

### Controller

#### Sorted

Allows to specify an order string.

```ruby
class UsersController < ApplicationController
  def index
    @users = User.sorted(params[:sort])
  end
end
```

#### Sorted!

Replaces any existing order defined on the relation with the specified order.

```ruby
class UsersController < ApplicationController
  def index
    if params[:sort].present?
        @users = User.sorted!(params[:sort])
    else
        @users = User.sorted(params[:sort])
    end
  end
end
```

### Sortiri's sort_link helper creates table headers that are sortable links

To use Sortiri's sort_link helper, simply include the Sortiri module on your ApplicationHelper.

```ruby
module ApplicationHelper
  include Sortiri::ViewHelpers::TableSorter
end
```

```erb
<%= sort_link(@users, :name, 'First Name') %>
```

```haml
= sort_link @users, :name, 'First Name'
```

Additionally css classes can be passed after the title attribute.

```erb
<%= sort_link(@users, :name, 'First Name', 'd-flex justify-content-center') %>
```

```haml
= sort_link @users, :name, 'First Name', 'd-flex justify-content-center'
```

### Configuration

Sortiri uses default up and down arrows for the view helper. This may be changed by
setting them in a Sortiri initializer file (typically `config/initializers/sortiri.rb`):

```ruby
Sortiri.configure do |c|
  c.up_arrow = 'fas fa-angle-up'
  c.down_arrow = 'fas fa-angle-down'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fabrikatorio/sortiri.

## License

Copyright © 2019–2021 [Fabrikatör](https://fabrikator.io).

Licensed under the MIT license, see [License](https://github.com/fabrikatorio/sortiri/blob/master/LICENSE.txt).
