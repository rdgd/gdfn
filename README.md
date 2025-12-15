# GDFN - Godot Functional Programming Library

A functional programming utility library for Godot 4, providing immutable array/dictionary operations and common FP patterns.

## Usage
To include as a Godotbot (a.k.a. bot) dependency. Add this library to your Botfile dependencies
```
[dependencies]
rdgd/gdfn v0.1.1
```
Then run `bot install` and include in your project like:
```
var Fn = Bot.file("gdfn");

var doubled = Fn.map([1, 2, 3], func(x): return x * 2)  # [2, 4, 6]
var sum = Fn.reduce([1, 2, 3], func(x, acc): return acc + x, 0)  # 6

```
Or copy-pasta, up to you.

## API Reference

### Core Array Operations

#### `map(a: Array, cb: Callable) -> Array`
Transforms each element using the callback function.
```gdscript
Fn.map([1, 2, 3], func(x): return x * 2)  # [2, 4, 6]
```

#### `mapIndexed(a: Array, cb: Callable) -> Array`
Maps with index as first argument. Returns elements in reverse order.
```gdscript
Fn.mapIndexed([10, 20, 30], func(i, x): return [i, x])
# [[2, 30], [1, 20], [0, 10]]
```

#### `filter(a: Array, cb: Callable) -> Array`
Returns elements that pass the predicate test.
```gdscript
Fn.filter([1, 2, 3, 4], func(x): return x % 2 == 0)  # [2, 4]
```

#### `reject(a: Array, predicate: Callable) -> Array`
Returns elements that fail the predicate test (opposite of filter).
```gdscript
Fn.reject([1, 2, 3, 4], func(x): return x % 2 == 0)  # [1, 3]
```

#### `reduce(a: Array, fn: Callable, acc) -> Variant`
Reduces array to single value by accumulating results.
```gdscript
Fn.reduce([1, 2, 3], func(x, acc): return acc + x, 0)  # 6
```

#### `reduceIndexed(a: Array, fn: Callable, acc) -> Variant`
Reduce with index as first argument.
```gdscript
Fn.reduceIndexed([10, 20], func(i, x, acc): return acc + i * x, 0)  # 20
```

#### `forEach(a: Array, cb: Callable) -> void`
Executes callback for each element (side effects only).
```gdscript
Fn.forEach([1, 2, 3], func(x): print(x))
```

### Array Searching & Testing

#### `find(a: Array, cb: Callable) -> Variant`
Returns first element matching predicate, or null.
```gdscript
Fn.find([1, 2, 3], func(x): return x > 1)  # 2
```

#### `findIndex(a: Array, cb: Callable) -> Variant`
Returns index of first matching element, or null.
```gdscript
Fn.findIndex([1, 2, 3], func(x): return x > 1)  # 1
```

#### `some(a: Array, cb: Callable) -> bool`
Returns true if any element passes the predicate.
```gdscript
Fn.some([1, 2, 3], func(x): return x > 2)  # true
```

#### `every(a: Array, cb: Callable) -> bool`
Returns true if all elements pass the predicate.
```gdscript
Fn.every([1, 2, 3], func(x): return x > 0)  # true
```

#### `includes(a: Array, value) -> bool`
Returns true if array contains the value.
```gdscript
Fn.includes([1, 2, 3], 2)  # true
```

#### `indexOf(a: Array, value) -> int`
Returns index of first occurrence of value, or -1.
```gdscript
Fn.indexOf([1, 2, 3, 2], 2)  # 1
```

#### `lastIndexOf(a: Array, value) -> int`
Returns index of last occurrence of value, or -1.
```gdscript
Fn.lastIndexOf([1, 2, 3, 2], 2)  # 3
```

### Array Access

#### `first(a: Array) -> Variant`
Returns first element or null if empty.
```gdscript
Fn.first([1, 2, 3])  # 1
Fn.first([])  # null
```

#### `last(a: Array) -> Variant`
Returns last element or null if empty.
```gdscript
Fn.last([1, 2, 3])  # 3
Fn.last([])  # null
```

#### `nth(a: Array, n: int) -> Variant`
Returns element at index n or null if out of bounds.
```gdscript
Fn.nth([1, 2, 3], 1)  # 2
Fn.nth([1, 2, 3], 5)  # null
```

#### `nthLast(a: Array, n: int) -> Variant`
Returns nth element from end or null if out of bounds.
```gdscript
Fn.nthLast([1, 2, 3], 0)  # 3
Fn.nthLast([1, 2, 3], 1)  # 2
```

### Array Transformations

#### `flatten(a: Array, depth: int = 1) -> Array`
Flattens nested arrays up to specified depth.
```gdscript
Fn.flatten([[1, 2], [3, 4]])  # [1, 2, 3, 4]
Fn.flatten([[[1]], [[2]]], 2)  # [1, 2]
```

#### `flatMap(a: Array, fn: Callable) -> Array`
Maps and flattens results in one operation.
```gdscript
Fn.flatMap([1, 2], func(x): return [x, x * 2])  # [1, 2, 2, 4]
```

#### `reverse(a: Array) -> Array`
Returns reversed copy of array.
```gdscript
Fn.reverse([1, 2, 3])  # [3, 2, 1]
```

#### `sort(a: Array) -> Array`
Returns sorted copy of array.
```gdscript
Fn.sort([3, 1, 2])  # [1, 2, 3]
```

#### `sortBy(a: Array, fn: Callable) -> Array`
Sorts by comparing values returned by function.
```gdscript
Fn.sortBy([{age: 30}, {age: 20}], func(x): return x.age)
# [{age: 20}, {age: 30}]
```

### Array Slicing

#### `take(a: Array, n: int) -> Array`
Returns first n elements.
```gdscript
Fn.take([1, 2, 3, 4], 2)  # [1, 2]
```

#### `drop(a: Array, n: int) -> Array`
Returns all elements except first n.
```gdscript
Fn.drop([1, 2, 3, 4], 2)  # [3, 4]
```

#### `takeWhile(a: Array, predicate: Callable) -> Array`
Takes elements while predicate is true, stops at first false.
```gdscript
Fn.takeWhile([1, 2, 3, 1], func(x): return x < 3)  # [1, 2]
```

#### `dropWhile(a: Array, predicate: Callable) -> Array`
Drops elements while predicate is true, returns rest.
```gdscript
Fn.dropWhile([1, 2, 3, 1], func(x): return x < 3)  # [3, 1]
```

#### `slice(a: Array, start: int, end: int = -1) -> Array`
Returns slice from start to end (exclusive). If end is -1, slices to end.
```gdscript
Fn.slice([1, 2, 3, 4], 1, 3)  # [2, 3]
Fn.slice([1, 2, 3, 4], 2)  # [3, 4]
```

### Array Filtering & Partitioning

#### `split(a: Array, predicate: Callable) -> Array`
Splits array into [truthy, falsy] based on predicate.
```gdscript
Fn.split([1, 2, 3, 4], func(x): return x % 2 == 0)
# [[2, 4], [1, 3]]
```

#### `compact(a: Array) -> Array`
Removes falsy values (null, false, 0, "").
```gdscript
Fn.compact([1, null, 2, false, 3, 0])  # [1, 2, 3]
```

#### `distinct(a: Array) -> Array`
Returns array with duplicate values removed.
```gdscript
Fn.distinct([1, 2, 2, 3, 1])  # [1, 2, 3]
```

#### `distinctBy(a: Array, fn: Callable) -> Array`
Returns array with duplicates removed based on function result.
```gdscript
Fn.distinctBy([{id: 1}, {id: 2}, {id: 1}], func(x): return x.id)
# [{id: 1}, {id: 2}]
```

### Grouping & Partitioning

#### `groupBy(a: Array, fn: Callable) -> Dictionary`
Groups elements by key returned from function.
```gdscript
Fn.groupBy([1, 2, 3, 4], func(x): return "even" if x % 2 == 0 else "odd")
# {"odd": [1, 3], "even": [2, 4]}
```

#### `partition(a: Array, size: int) -> Array`
Splits array into fixed-size partitions, dropping incomplete final partition.
```gdscript
Fn.partition([1, 2, 3, 4, 5], 2)  # [[1, 2], [3, 4]]
Fn.partition([1, 2, 3, 4], 2)  # [[1, 2], [3, 4]]
```

#### `partitionAll(a: Array, size: int) -> Array`
Splits array into fixed-size partitions, keeping incomplete final partition.
```gdscript
Fn.partitionAll([1, 2, 3, 4, 5], 2)  # [[1, 2], [3, 4], [5]]
Fn.partitionAll([1, 2, 3, 4], 2)  # [[1, 2], [3, 4]]
```

#### `countBy(a: Array, fn: Callable) -> Dictionary`
Counts elements by key returned from function.
```gdscript
Fn.countBy([1, 2, 3, 4], func(x): return "even" if x % 2 == 0 else "odd")
# {"odd": 2, "even": 2}
```

### Array Aggregation

#### `sum(a: Array) -> float`
Returns sum of all elements.
```gdscript
Fn.sum([1, 2, 3])  # 6.0
```

#### `product(a: Array) -> float`
Returns product of all elements.
```gdscript
Fn.product([2, 3, 4])  # 24.0
```

#### `min(a: Array) -> Variant`
Returns minimum element or null if empty.
```gdscript
Fn.min([3, 1, 2])  # 1
```

#### `max(a: Array) -> Variant`
Returns maximum element or null if empty.
```gdscript
Fn.max([3, 1, 2])  # 3
```

#### `minBy(a: Array, fn: Callable) -> Variant`
Returns element with minimum value from function.
```gdscript
Fn.minBy([{age: 30}, {age: 20}], func(x): return x.age)  # {age: 20}
```

#### `maxBy(a: Array, fn: Callable) -> Variant`
Returns element with maximum value from function.
```gdscript
Fn.maxBy([{age: 30}, {age: 20}], func(x): return x.age)  # {age: 30}
```

#### `mean(a: Array) -> float`
Returns arithmetic mean (average) of elements.
```gdscript
Fn.mean([1, 2, 3])  # 2.0
```

### Set Operations

#### `union(a: Array, b: Array) -> Array`
Returns union of two arrays (distinct combined elements).
```gdscript
Fn.union([1, 2], [2, 3])  # [1, 2, 3]
```

#### `intersection(a: Array, b: Array) -> Array`
Returns elements present in both arrays.
```gdscript
Fn.intersection([1, 2, 3], [2, 3, 4])  # [2, 3]
```

#### `difference(a: Array, b: Array) -> Array`
Returns elements in first array but not in second.
```gdscript
Fn.difference([1, 2, 3], [2, 3, 4])  # [1]
```

### Zipping & Combining

#### `zip(a: Array, b: Array) -> Array`
Combines two arrays into array of pairs.
```gdscript
Fn.zip([1, 2, 3], ["a", "b", "c"])  # [[1, "a"], [2, "b"], [3, "c"]]
```

#### `zipWith(a: Array, b: Array, fn: Callable) -> Array`
Combines two arrays using function.
```gdscript
Fn.zipWith([1, 2], [10, 20], func(x, y): return x + y)  # [11, 22]
```

#### `zipWithIndex(a: Array, fn: Callable) -> Array`
Combines elements with their indices using function.
```gdscript
Fn.zipWithIndex(["a", "b"], func(i, x): return str(i) + x)  # ["0a", "1b"]
```

#### `concat(arrays: Array) -> Array`
Concatenates multiple arrays into one.
```gdscript
Fn.concat([[1, 2], [3, 4], [5]])  # [1, 2, 3, 4, 5]
```

### Array Utilities

#### `isEmpty(a: Array) -> bool`
Returns true if array is empty.
```gdscript
Fn.isEmpty([])  # true
```

#### `isNotEmpty(a: Array) -> bool`
Returns true if array is not empty.
```gdscript
Fn.isNotEmpty([1])  # true
```

#### `count(a: Array) -> int`
Returns number of elements in array.
```gdscript
Fn.count([1, 2, 3])  # 3
```

#### `join(a: Array, separator: String = "") -> String`
Joins array elements into string with separator.
```gdscript
Fn.join([1, 2, 3], ", ")  # "1, 2, 3"
```

### Dictionary Operations

#### `mapKv(d: Dictionary, fn: Callable) -> Dictionary`
Maps over dictionary key-value pairs.
```gdscript
Fn.mapKv({a: 1, b: 2}, func(k, v): return v * 2)  # {a: 2, b: 4}
```

#### `reduceKv(d: Dictionary, fn: Callable, acc) -> Variant`
Reduces dictionary to single value.
```gdscript
Fn.reduceKv({a: 1, b: 2}, func(k, v, acc): return acc + v, 0)  # 3
```

#### `pluck(a: Array, key: String) -> Array`
Extracts property from array of dictionaries.
```gdscript
Fn.pluck([{id: 1, name: "A"}, {id: 2, name: "B"}], "name")  # ["A", "B"]
```

#### `pick(d: Dictionary, key_list: Array) -> Dictionary`
Returns new dictionary with only specified keys.
```gdscript
Fn.pick({a: 1, b: 2, c: 3}, ["a", "c"])  # {a: 1, c: 3}
```

#### `omit(d: Dictionary, key_list: Array) -> Dictionary`
Returns new dictionary without specified keys.
```gdscript
Fn.omit({a: 1, b: 2, c: 3}, ["b"])  # {a: 1, c: 3}
```

#### `keys(d: Dictionary) -> Array`
Returns array of dictionary keys.
```gdscript
Fn.keys({a: 1, b: 2})  # ["a", "b"]
```

#### `values(d: Dictionary) -> Array`
Returns array of dictionary values.
```gdscript
Fn.values({a: 1, b: 2})  # [1, 2]
```

#### `entries(d: Dictionary) -> Array`
Returns array of [key, value] pairs.
```gdscript
Fn.entries({a: 1, b: 2})  # [["a", 1], ["b", 2]]
```

#### `fromEntries(entry_list: Array) -> Dictionary`
Creates dictionary from array of [key, value] pairs.
```gdscript
Fn.fromEntries([["a", 1], ["b", 2]])  # {a: 1, b: 2}
```

#### `merge(a: Dictionary, b: Dictionary) -> Dictionary`
Merges two dictionaries (b overwrites a).
```gdscript
Fn.merge({a: 1, b: 2}, {b: 3, c: 4})  # {a: 1, b: 3, c: 4}
```

### Generator Functions

#### `range(start: int, end: int = -1, step: int = 1) -> Array`
Generates array of integers from start to end (exclusive).
```gdscript
Fn.range(5)  # [0, 1, 2, 3, 4]
Fn.range(2, 5)  # [2, 3, 4]
Fn.range(0, 10, 2)  # [0, 2, 4, 6, 8]
```

#### `repeat(value, n: int) -> Array`
Creates array with value repeated n times.
```gdscript
Fn.repeat("x", 3)  # ["x", "x", "x"]
```

#### `times(n: int, fn: Callable) -> Array`
Calls function n times with index, returns results.
```gdscript
Fn.times(3, func(i): return i * 2)  # [0, 2, 4]
```

### Function Utilities

#### `tap(value, fn: Callable) -> Variant`
Calls function with value for side effects, returns value.
```gdscript
Fn.tap([1, 2, 3], func(x): print(x))  # prints [1, 2, 3], returns [1, 2, 3]
```

#### `identity(value) -> Variant`
Returns the value unchanged.
```gdscript
Fn.identity(5)  # 5
```

#### `constant(value) -> Callable`
Returns function that always returns value.
```gdscript
var always5 = Fn.constant(5)
always5.call()  # 5
```

#### `noop() -> void`
No-operation function (does nothing).
```gdscript
Fn.noop()  # does nothing
```

### Function Composition

#### `compose(functions: Array) -> Callable`
Composes functions right-to-left.
```gdscript
var add1 = func(x): return x + 1
var mult2 = func(x): return x * 2
var f = Fn.compose([add1, mult2])
f.call(5)  # 11 (5 * 2 + 1)
```

#### `pipe(functions: Array) -> Callable`
Composes functions left-to-right.
```gdscript
var add1 = func(x): return x + 1
var mult2 = func(x): return x * 2
var f = Fn.pipe([add1, mult2])
f.call(5)  # 12 ((5 + 1) * 2)
```

#### `partial(fn: Callable, bound_args: Array) -> Callable`
Partially applies arguments to function.
```gdscript
var add = func(x, y): return x + y
var add5 = Fn.partial(add, [5])
add5.call([3])  # 8
```

## Examples

### Data Pipeline
```gdscript
const Fn = preload("res://index.gd")

var data = [
    {name: "Alice", age: 30, active: true},
    {name: "Bob", age: 25, active: false},
    {name: "Charlie", age: 35, active: true}
]

# Get names of active users over 28
var result = Fn.pipe([
    func(arr): return Fn.filter(arr, func(u): return u.active),
    func(arr): return Fn.filter(arr, func(u): return u.age > 28),
    func(arr): return Fn.pluck(arr, "name")
]).call(data)
# ["Alice", "Charlie"]
```

### Complex Aggregation
```gdscript
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Group by even/odd and sum each group
var grouped = Fn.groupBy(numbers, func(x): return "even" if x % 2 == 0 else "odd")
var sums = Fn.mapKv(grouped, func(k, v): return Fn.sum(v))
# {odd: 25, even: 30}
```

### Chaining Operations
```gdscript
var prices = [10, 25, 30, 15, 20]

# Get expensive items (>20), apply discount, calculate total
var total = Fn.reduce(
    Fn.map(
        Fn.filter(prices, func(p): return p > 20),
        func(p): return p * 0.9
    ),
    func(p, acc): return acc + p,
    0
)
# 49.5
```

## License

MIT License - Free to use in your projects

