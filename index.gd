## Functional Programming Utilities
## A comprehensive library of functional programming helpers for arrays and dictionaries.
## All functions are static and can be called directly via the class name.
extends Object

## Maps over an array with index awareness, applying the callback to each element.
## @param a: The array to map over
## @param cb: Callable that receives (index: int, element: Variant) and returns transformed value
## @return: New array with transformed values in reverse order
static func mapIndexed(a:Array, cb:Callable) -> Array:
	var ret = []
	for i in a.size():
		ret.push_front(cb.call(i, a[i]))
	
	return ret

## Reduces an array to a single value with index awareness.
## @param a: The array to reduce
## @param fn: Callable that receives (index: int, element: Variant, accumulator: Variant)
## @param acc: Initial accumulator value
## @return: Final accumulated value
static func reduceIndexed(a:Array, fn:Callable, acc):
	for i in a.size():
		acc = fn.call(i, a[i], acc)
	return acc

## Executes a callback for each element in the array.
## @param a: The array to iterate over
## @param cb: Callable that receives (element: Variant)
static func forEach(a:Array, cb:Callable) -> void:
	for el in a:
		cb.call(el)

## No-operation function that does nothing and returns null.
static func noop(): return

## Maps over an array, applying the callback to each element.
## @param a: The array to map over
## @param cb: Callable that receives (element: Variant) and returns transformed value
## @return: New array with transformed values
static func map(a:Array, cb:Callable) -> Array:
	var ret = []
	for el in a:
		ret.append(cb.call(el))
	return ret

## Filters an array, keeping only elements for which the callback returns true.
## @param a: The array to filter
## @param cb: Callable that receives (element: Variant) and returns bool
## @return: New array containing only matching elements
static func filter(a:Array, cb:Callable) -> Array:
	var ret = []
	for el in a:
		if cb.call(el):
			ret.append(el)
	return ret

## Checks if at least one element in the array satisfies the callback.
## @param a: The array to check
## @param cb: Callable that receives (element: Variant) and returns bool
## @return: true if any element matches, false otherwise
static func some(a:Array, cb:Callable) -> bool:
	for el in a:
		if cb.call(el):
			return true
	return false

## Checks if all elements in the array satisfy the callback.
## @param a: The array to check
## @param cb: Callable that receives (element: Variant) and returns bool
## @return: true if all elements match, false otherwise
static func every(a:Array, cb:Callable) -> bool:
	for el in a:
		if !cb.call(el):
			return false
	return true

## Finds the first element in the array that satisfies the callback.
## @param a: The array to search
## @param cb: Callable that receives (element: Variant) and returns bool
## @return: The first matching element, or null if none found
static func find(a:Array, cb:Callable) -> Variant:
	for el in a:
		if cb.call(el):
			return el
	return null

## Finds the index of the first element that satisfies the callback.
## @param a: The array to search
## @param cb: Callable that receives (element: Variant) and returns bool
## @return: The index of the first match, or null if none found
static func findIndex(a:Array, cb:Callable) -> Variant:
	for i in a.size():
		if cb.call(a[i]):
			return i
	return null

## Returns the first element of an array.
## @param a: The array
## @return: The first element, or null if array is empty
static func first(a:Array) -> Variant:
	if a.is_empty():
		return null
	return a[0]

## Returns the last element of an array.
## @param a: The array
## @return: The last element, or null if array is empty
static func last(a:Array) -> Variant:
	if a.is_empty():
		return null
	return a[a.size() - 1]

## Returns the nth element of an array (0-indexed).
## @param a: The array
## @param n: The index to retrieve
## @return: The element at index n, or null if out of bounds or empty
static func nth(a:Array, n:int) -> Variant:
	if a.is_empty():
		return null
	if n < 0 or n >= a.size():
		return null
	return a[n]

## Returns the nth element from the end of an array (0-indexed from end).
## @param a: The array
## @param n: The index from the end (0 = last element)
## @return: The element at position n from end, or null if out of bounds or empty
static func nthLast(a:Array, n:int) -> Variant:
	if a.is_empty():
		return null
	if n < 0 or n >= a.size():
		return null
	return a[a.size() - n - 1]

## Combines two arrays into an array of pairs.
## @param a: First array
## @param b: Second array
## @return: Array of [a[i], b[i]] pairs
static func zip(a:Array, b:Array) -> Array:
	var ret = []
	for i in a.size():
		ret.append([a[i], b[i]])
	return ret

## Combines two arrays using a custom function.
## @param a: First array
## @param b: Second array
## @param fn: Callable that receives (element_a: Variant, element_b: Variant)
## @return: Array of results from applying fn to each pair
static func zipWith(a:Array, b:Array, fn:Callable) -> Array:
	var ret = []
	for i in a.size():
		ret.append(fn.call(a[i], b[i]))
	return ret

## Maps over an array with both index and value.
## @param a: The array to map over
## @param fn: Callable that receives (index: int, element: Variant)
## @return: Array of results from applying fn to each index-element pair
static func zipWithIndex(a:Array, fn:Callable) -> Array:
	var ret = []
	for i in a.size():
		ret.append(fn.call(i, a[i]))
	return ret

## Reduces an array to a single value.
## @param a: The array to reduce
## @param fn: Callable that receives (element: Variant, accumulator: Variant)
## @param acc: Initial accumulator value
## @return: Final accumulated value
static func reduce(a:Array, fn:Callable, acc):
	for el in a:
		acc = fn.call(el, acc)
	return acc

## Maps over a dictionary's key-value pairs.
## @param d: The dictionary to map over
## @param fn: Callable that receives (key: Variant, value: Variant) and returns new value
## @return: New dictionary with transformed values
static func mapKv(d:Dictionary, fn:Callable) -> Dictionary:
	var ret = {}
	for k in d:
		ret[k] = fn.call(k, d[k])
	return ret

## Reduces a dictionary to a single value.
## @param d: The dictionary to reduce
## @param fn: Callable that receives (key: Variant, value: Variant, accumulator: Variant)
## @param acc: Initial accumulator value
## @return: Final accumulated value
static func reduceKv(d:Dictionary, fn:Callable, acc):
	var internal = acc
	for k in d:
		internal = fn.call(k, d[k], internal)
	return internal

## Flattens a nested array structure to a specified depth.
## @param a: The array to flatten
## @param depth: How many levels deep to flatten (default: 1)
## @return: Flattened array
static func flatten(a:Array, depth:int = 1) -> Array:
	if depth == 0:
		return a
	var ret = []
	for el in a:
		if el is Array:
			ret.append_array(flatten(el, depth - 1))
		else:
			ret.append(el)
	return ret

## Maps over an array and flattens the results by one level.
## @param a: The array to map over
## @param fn: Callable that receives (element: Variant) and may return an array or single value
## @return: Flattened array of all results
static func flatMap(a:Array, fn:Callable) -> Array:
	var ret = []
	for el in a:
		var result = fn.call(el)
		if result is Array:
			ret.append_array(result)
		else:
			ret.append(result)
	return ret

## Returns a reversed copy of an array.
## @param a: The array to reverse
## @return: New array with elements in reverse order
static func reverse(a:Array) -> Array:
	var ret = a.duplicate()
	ret.reverse()
	return ret

## Returns a sorted copy of an array using default comparison.
## @param a: The array to sort
## @return: New sorted array
static func sort(a:Array) -> Array:
	var ret = a.duplicate()
	ret.sort()
	return ret

## Returns a sorted copy of an array using a custom sorting key.
## @param a: The array to sort
## @param fn: Callable that receives (element: Variant) and returns a comparable value
## @return: New array sorted by the key function
static func sortBy(a:Array, fn:Callable) -> Array:
	var ret = a.duplicate()
	ret.sort_custom(func(x, y): return fn.call(x) < fn.call(y))
	return ret

## Takes the first n elements from an array.
## @param a: The array
## @param n: Number of elements to take
## @return: New array with first n elements
static func take(a:Array, n:int) -> Array:
	return a.slice(0, n)

## Drops the first n elements from an array.
## @param a: The array
## @param n: Number of elements to drop
## @return: New array without the first n elements
static func drop(a:Array, n:int) -> Array:
	return a.slice(n)

## Takes elements from the start while predicate returns true.
## @param a: The array
## @param predicate: Callable that receives (element: Variant) and returns bool
## @return: New array with elements taken until predicate fails
static func takeWhile(a:Array, predicate:Callable) -> Array:
	var ret = []
	for el in a:
		if predicate.call(el):
			ret.append(el)
		else:
			break
	return ret

## Drops elements from the start while predicate returns true.
## @param a: The array
## @param predicate: Callable that receives (element: Variant) and returns bool
## @return: New array with elements after predicate first fails
static func dropWhile(a:Array, predicate:Callable) -> Array:
	var i = 0
	while i < a.size() and predicate.call(a[i]):
		i += 1
	return a.slice(i)

## Returns a slice of an array from start to end.
## @param a: The array to slice
## @param start: Starting index (inclusive)
## @param end: Ending index (exclusive), or -1 for end of array
## @return: New array containing the slice
static func slice(a:Array, start:int, end:int = -1) -> Array:
	if end == -1:
		end = a.size()
	return a.slice(start, end)

## Returns elements that don't satisfy the predicate (opposite of filter).
## @param a: The array to filter
## @param predicate: Callable that receives (element: Variant) and returns bool
## @return: New array with elements where predicate returns false
static func reject(a:Array, predicate:Callable) -> Array:
	var ret = []
	for el in a:
		if !predicate.call(el):
			ret.append(el)
	return ret

## Partitions an array into two arrays based on a predicate.
## @param a: The array to split
## @param predicate: Callable that receives (element: Variant) and returns bool
## @return: Array with two elements: [truthy_elements, falsy_elements]
static func split(a:Array, predicate:Callable) -> Array:
	var truthy = []
	var falsy = []
	for el in a:
		if predicate.call(el):
			truthy.append(el)
		else:
			falsy.append(el)
	return [truthy, falsy]

## Removes falsy values (null, false, 0, empty strings) from an array.
## @param a: The array to compact
## @return: New array with only truthy values
static func compact(a:Array) -> Array:
	var ret = []
	for el in a:
		if el:
			ret.append(el)
	return ret

## Returns an array with duplicate values removed.
## @param a: The array to deduplicate
## @return: New array with unique elements
static func distinct(a:Array) -> Array:
	var ret = []
	var seen = {}
	for el in a:
		var key = str(el)
		if !seen.has(key):
			seen[key] = true
			ret.append(el)
	return ret

## Returns an array with duplicates removed based on a key function.
## @param a: The array to deduplicate
## @param fn: Callable that receives (element: Variant) and returns a comparable key
## @return: New array with unique elements by key
static func distinctBy(a:Array, fn:Callable) -> Array:
	var ret = []
	var seen = {}
	for el in a:
		var key = str(fn.call(el))
		if !seen.has(key):
			seen[key] = true
			ret.append(el)
	return ret

## Groups array elements by a key function.
## @param a: The array to group
## @param fn: Callable that receives (element: Variant) and returns a grouping key
## @return: Dictionary mapping keys to arrays of elements
static func groupBy(a:Array, fn:Callable) -> Dictionary:
	var ret = {}
	for el in a:
		var key = fn.call(el)
		if !ret.has(key):
			ret[key] = []
		ret[key].append(el)
	return ret

## Partitions an array into chunks of specified size (drops incomplete chunks).
## @param a: The array to partition
## @param size: Size of each chunk
## @return: Array of arrays, each containing 'size' elements
static func partition(a:Array, size:int) -> Array:
	var ret = []
	var i = 0
	while i + size <= a.size():
		ret.append(a.slice(i, i + size))
		i += size
	return ret

## Partitions an array into chunks of specified size (includes incomplete chunks).
## @param a: The array to partition
## @param size: Size of each chunk
## @return: Array of arrays, with the last chunk possibly smaller than 'size'
static func partitionAll(a:Array, size:int) -> Array:
	var ret = []
	var i = 0
	while i < a.size():
		ret.append(a.slice(i, i + size))
		i += size
	return ret

## Counts occurrences of values grouped by a key function.
## @param a: The array to count
## @param fn: Callable that receives (element: Variant) and returns a grouping key
## @return: Dictionary mapping keys to counts
static func countBy(a:Array, fn:Callable) -> Dictionary:
	var ret = {}
	for el in a:
		var key = fn.call(el)
		if !ret.has(key):
			ret[key] = 0
		ret[key] += 1
	return ret

## Checks if an array contains a value.
## @param a: The array to search
## @param value: The value to look for
## @return: true if value is found, false otherwise
static func includes(a:Array, value) -> bool:
	return a.has(value)

## Finds the first index of a value in an array.
## @param a: The array to search
## @param value: The value to find
## @return: Index of first occurrence, or -1 if not found
static func indexOf(a:Array, value) -> int:
	return a.find(value)

## Finds the last index of a value in an array.
## @param a: The array to search
## @param value: The value to find
## @return: Index of last occurrence, or -1 if not found
static func lastIndexOf(a:Array, value) -> int:
	return a.rfind(value)

## Calculates the sum of all numeric elements in an array.
## @param a: Array of numbers
## @return: Sum of all elements as float
static func sum(a:Array) -> float:
	var total = 0.0
	for el in a:
		total += el
	return total

## Calculates the product of all numeric elements in an array.
## @param a: Array of numbers
## @return: Product of all elements as float
static func product(a:Array) -> float:
	var total = 1.0
	for el in a:
		total *= el
	return total

## Finds the minimum value in an array.
## @param a: The array to search
## @return: Minimum value, or null if array is empty
static func min(a:Array):
	if a.is_empty():
		return null
	var minimum = a[0]
	for el in a:
		if el < minimum:
			minimum = el
	return minimum

## Finds the maximum value in an array.
## @param a: The array to search
## @return: Maximum value, or null if array is empty
static func max(a:Array):
	if a.is_empty():
		return null
	var maximum = a[0]
	for el in a:
		if el > maximum:
			maximum = el
	return maximum

## Finds the element with minimum value according to a key function.
## @param a: The array to search
## @param fn: Callable that receives (element: Variant) and returns a comparable value
## @return: Element with minimum key value, or null if array is empty
static func minBy(a:Array, fn:Callable):
	if a.is_empty():
		return null
	var minimum = a[0]
	var minValue = fn.call(minimum)
	for el in a:
		var value = fn.call(el)
		if value < minValue:
			minValue = value
			minimum = el
	return minimum

## Finds the element with maximum value according to a key function.
## @param a: The array to search
## @param fn: Callable that receives (element: Variant) and returns a comparable value
## @return: Element with maximum key value, or null if array is empty
static func maxBy(a:Array, fn:Callable):
	if a.is_empty():
		return null
	var maximum = a[0]
	var maxValue = fn.call(maximum)
	for el in a:
		var value = fn.call(el)
		if value > maxValue:
			maxValue = value
			maximum = el
	return maximum

## Calculates the arithmetic mean (average) of array elements.
## @param a: Array of numbers
## @return: Mean value as float, or 0.0 if array is empty
static func mean(a:Array) -> float:
	if a.is_empty():
		return 0.0
	return sum(a) / a.size()

## Returns the union of two arrays (all unique elements from both).
## @param a: First array
## @param b: Second array
## @return: New array with all unique elements from both arrays
static func union(a:Array, b:Array) -> Array:
	return distinct(a + b)

## Returns the intersection of two arrays (elements present in both).
## @param a: First array
## @param b: Second array
## @return: New array with elements that appear in both arrays
static func intersection(a:Array, b:Array) -> Array:
	var ret = []
	for el in a:
		if b.has(el) and !ret.has(el):
			ret.append(el)
	return ret

## Returns the difference of two arrays (elements in a that are not in b).
## @param a: First array
## @param b: Second array
## @return: New array with elements from a that are not in b
static func difference(a:Array, b:Array) -> Array:
	var ret = []
	for el in a:
		if !b.has(el):
			ret.append(el)
	return ret

## Checks if an array is empty.
## @param a: The array to check
## @return: true if array is empty, false otherwise
static func isEmpty(a:Array) -> bool:
	return a.is_empty()

## Checks if an array is not empty.
## @param a: The array to check
## @return: true if array has elements, false otherwise
static func isNotEmpty(a:Array) -> bool:
	return !a.is_empty()

## Returns the number of elements in an array.
## @param a: The array to count
## @return: Number of elements
static func count(a:Array) -> int:
	return a.size()

## Joins array elements into a string with a separator.
## @param a: Array of values to join
## @param separator: String to insert between elements (default: "")
## @return: Joined string
static func join(a:Array, separator:String = "") -> String:
	return separator.join(a)

## Concatenates multiple arrays into one.
## @param arrays: Array of arrays to concatenate
## @return: New array with all elements from all arrays
static func concat(arrays:Array) -> Array:
	var ret = []
	for arr in arrays:
		ret.append_array(arr)
	return ret

## Extracts a property from each dictionary in an array.
## @param a: Array of dictionaries
## @param key: Property key to extract
## @return: Array of values for the specified key
static func pluck(a:Array, key:String) -> Array:
	var ret = []
	for el in a:
		if el is Dictionary and el.has(key):
			ret.append(el[key])
	return ret

## Creates a new dictionary with only specified keys.
## @param d: Source dictionary
## @param key_list: Array of keys to include
## @return: New dictionary with only the specified keys
static func pick(d:Dictionary, key_list:Array) -> Dictionary:
	var ret = {}
	for key in key_list:
		if d.has(key):
			ret[key] = d[key]
	return ret

## Creates a new dictionary excluding specified keys.
## @param d: Source dictionary
## @param key_list: Array of keys to exclude
## @return: New dictionary without the specified keys
static func omit(d:Dictionary, key_list:Array) -> Dictionary:
	var ret = d.duplicate()
	for key in key_list:
		ret.erase(key)
	return ret

## Returns all keys from a dictionary.
## @param d: The dictionary
## @return: Array of keys
static func keys(d:Dictionary) -> Array:
	return d.keys()

## Returns all values from a dictionary.
## @param d: The dictionary
## @return: Array of values
static func values(d:Dictionary) -> Array:
	return d.values()

## Converts a dictionary to an array of [key, value] pairs.
## @param d: The dictionary
## @return: Array of [key, value] arrays
static func entries(d:Dictionary) -> Array:
	var ret = []
	for k in d:
		ret.append([k, d[k]])
	return ret

## Creates a dictionary from an array of [key, value] pairs.
## @param entry_list: Array of [key, value] arrays
## @return: New dictionary
static func fromEntries(entry_list:Array) -> Dictionary:
	var ret = {}
	for entry in entry_list:
		ret[entry[0]] = entry[1]
	return ret

## Merges two dictionaries (b's values override a's).
## @param a: First dictionary
## @param b: Second dictionary
## @return: New merged dictionary
static func merge(a:Dictionary, b:Dictionary) -> Dictionary:
	var ret = a.duplicate()
	ret.merge(b)
	return ret

## Creates an array of integers in a range.
## @param start: Starting value (or end value if end is -1)
## @param end: Ending value (exclusive), or -1 to use start as end and 0 as start
## @param step: Step size (default: 1)
## @return: Array of integers from start to end
static func range(start:int, end:int = -1, step:int = 1) -> Array:
	var ret = []
	var actualStart:int
	var actualEnd:int
	if end == -1:
		actualStart = 0
		actualEnd = start
	else:
		actualStart = start
		actualEnd = end
	var i = actualStart
	while (step > 0 and i < actualEnd) or (step < 0 and i > actualEnd):
		ret.append(i)
		i += step
	return ret

## Creates an array with a value repeated n times.
## @param value: The value to repeat
## @param n: Number of times to repeat
## @return: Array with value repeated n times
static func repeat(value, n:int) -> Array:
	var ret = []
	for i in range(n):
		ret.append(value)
	return ret

## Calls a function n times and collects the results.
## @param n: Number of times to call the function
## @param fn: Callable that receives (index: int) and returns a value
## @return: Array of results from each call
static func times(n:int, fn:Callable) -> Array:
	var ret = []
	for i in range(n):
		ret.append(fn.call(i))
	return ret

## Executes a function with a value and returns the value unchanged.
## Useful for debugging or side effects in function chains.
## @param value: The value to pass through
## @param fn: Callable that receives (value: Variant) for side effects
## @return: The original value
static func tap(value, fn:Callable):
	fn.call(value)
	return value

## Identity function that returns its argument unchanged.
## @param value: Any value
## @return: The same value
static func identity(value):
	return value

## Creates a function that always returns the same value.
## @param value: The value to return
## @return: Callable that returns the constant value
static func constant(value) -> Callable:
	return func(): return value

## Composes functions right-to-left.
## @param functions: Array of callables to compose
## @return: Callable that applies functions from right to left
static func compose(functions:Array) -> Callable:
	return func(x):
		var result = x
		for i in range(functions.size() - 1, -1, -1):
			result = functions[i].call(result)
		return result

## Pipes functions left-to-right (reverse of compose).
## @param functions: Array of callables to pipe
## @return: Callable that applies functions from left to right
static func pipe(functions:Array) -> Callable:
	return func(x):
		var result = x
		for fn in functions:
			result = fn.call(result)
		return result

## Creates a partially applied function with bound arguments.
## @param fn: The function to partially apply
## @param bound_args: Array of arguments to bind
## @return: Callable with bound arguments pre-filled
static func partial(fn:Callable, bound_args:Array) -> Callable:
	return func(additional_args = []):
		var all_args = bound_args.duplicate()
		if additional_args is Array:
			all_args.append_array(additional_args)
		else:
			all_args.append(additional_args)
		return fn.callv(all_args)