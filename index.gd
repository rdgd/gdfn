extends Object

static func mapIndexed(a:Array, cb:Callable) -> Array:
	var ret = []
	for i in a.size():
		ret.push_front(cb.call(i, a[i]))
	
	return ret

static func reduceIndexed(a:Array, fn:Callable, acc):
	for i in a.size():
		acc = fn.call(i, a[i], acc)
	return acc
	
static func forEach(a:Array, cb:Callable) -> void:
	for el in a:
		cb.call(el)
	
static func noop(): return

static func map(a:Array, cb:Callable) -> Array:
	var ret = []
	for el in a:
		ret.append(cb.call(el))
	return ret

static func filter(a:Array, cb:Callable) -> Array:
	var ret = []
	for el in a:
		if cb.call(el):
			ret.append(el)
	return ret

static func some(a:Array, cb:Callable) -> bool:
	for el in a:
		if cb.call(el):
			return true
	return false

static func every(a:Array, cb:Callable) -> bool:
	for el in a:
		if !cb.call(el):
			return false
	return true

static func find(a:Array, cb:Callable) -> Variant:
	for el in a:
		if cb.call(el):
			return el
	return null

static func findIndex(a:Array, cb:Callable) -> Variant:
	for i in a.size():
		if cb.call(a[i]):
			return i
	return null

static func first(a:Array) -> Variant:
	if a.is_empty():
		return null
	return a[0]

static func last(a:Array) -> Variant:
	if a.is_empty():
		return null
	return a[a.size() - 1]

static func nth(a:Array, n:int) -> Variant:
	if a.is_empty():
		return null
	if n < 0 or n >= a.size():
		return null
	return a[n]

static func nthLast(a:Array, n:int) -> Variant:
	if a.is_empty():
		return null
	if n < 0 or n >= a.size():
		return null
	return a[a.size() - n - 1]

static func zip(a:Array, b:Array) -> Array:
	var ret = []
	for i in a.size():
		ret.append([a[i], b[i]])
	return ret

static func zipWith(a:Array, b:Array, fn:Callable) -> Array:
	var ret = []
	for i in a.size():
		ret.append(fn.call(a[i], b[i]))
	return ret

static func zipWithIndex(a:Array, fn:Callable) -> Array:
	var ret = []
	for i in a.size():
		ret.append(fn.call(i, a[i]))
	return ret

static func reduce(a:Array, fn:Callable, acc):
	for el in a:
		acc = fn.call(el, acc)
	return acc

static func mapKv(d:Dictionary, fn:Callable) -> Dictionary:
	var ret = {}
	for k in d:
		ret[k] = fn.call(k, d[k])
	return ret

static func reduceKv(d:Dictionary, fn:Callable, acc):
	var internal = acc
	for k in d:
		internal = fn.call(k, d[k], internal)
	return internal

# Array transformations
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

static func flatMap(a:Array, fn:Callable) -> Array:
	var ret = []
	for el in a:
		var result = fn.call(el)
		if result is Array:
			ret.append_array(result)
		else:
			ret.append(result)
	return ret

static func reverse(a:Array) -> Array:
	var ret = a.duplicate()
	ret.reverse()
	return ret

static func sort(a:Array) -> Array:
	var ret = a.duplicate()
	ret.sort()
	return ret

static func sortBy(a:Array, fn:Callable) -> Array:
	var ret = a.duplicate()
	ret.sort_custom(func(x, y): return fn.call(x) < fn.call(y))
	return ret

# Array slicing
static func take(a:Array, n:int) -> Array:
	return a.slice(0, n)

static func drop(a:Array, n:int) -> Array:
	return a.slice(n)

static func takeWhile(a:Array, predicate:Callable) -> Array:
	var ret = []
	for el in a:
		if predicate.call(el):
			ret.append(el)
		else:
			break
	return ret

static func dropWhile(a:Array, predicate:Callable) -> Array:
	var i = 0
	while i < a.size() and predicate.call(a[i]):
		i += 1
	return a.slice(i)

static func slice(a:Array, start:int, end:int = -1) -> Array:
	if end == -1:
		end = a.size()
	return a.slice(start, end)

# Array filtering and partitioning
static func reject(a:Array, predicate:Callable) -> Array:
	var ret = []
	for el in a:
		if !predicate.call(el):
			ret.append(el)
	return ret

static func split(a:Array, predicate:Callable) -> Array:
	var truthy = []
	var falsy = []
	for el in a:
		if predicate.call(el):
			truthy.append(el)
		else:
			falsy.append(el)
	return [truthy, falsy]

static func compact(a:Array) -> Array:
	var ret = []
	for el in a:
		if el:
			ret.append(el)
	return ret

static func distinct(a:Array) -> Array:
	var ret = []
	var seen = {}
	for el in a:
		var key = str(el)
		if !seen.has(key):
			seen[key] = true
			ret.append(el)
	return ret

static func distinctBy(a:Array, fn:Callable) -> Array:
	var ret = []
	var seen = {}
	for el in a:
		var key = str(fn.call(el))
		if !seen.has(key):
			seen[key] = true
			ret.append(el)
	return ret

# Grouping and chunking
static func groupBy(a:Array, fn:Callable) -> Dictionary:
	var ret = {}
	for el in a:
		var key = fn.call(el)
		if !ret.has(key):
			ret[key] = []
		ret[key].append(el)
	return ret

static func partition(a:Array, size:int) -> Array:
	var ret = []
	var i = 0
	while i + size <= a.size():
		ret.append(a.slice(i, i + size))
		i += size
	return ret

static func partitionAll(a:Array, size:int) -> Array:
	var ret = []
	var i = 0
	while i < a.size():
		ret.append(a.slice(i, i + size))
		i += size
	return ret

static func countBy(a:Array, fn:Callable) -> Dictionary:
	var ret = {}
	for el in a:
		var key = fn.call(el)
		if !ret.has(key):
			ret[key] = 0
		ret[key] += 1
	return ret

# Array searching
static func includes(a:Array, value) -> bool:
	return a.has(value)

static func indexOf(a:Array, value) -> int:
	return a.find(value)

static func lastIndexOf(a:Array, value) -> int:
	return a.rfind(value)

# Array aggregation
static func sum(a:Array) -> float:
	var total = 0.0
	for el in a:
		total += el
	return total

static func product(a:Array) -> float:
	var total = 1.0
	for el in a:
		total *= el
	return total

static func min(a:Array):
	if a.is_empty():
		return null
	var minimum = a[0]
	for el in a:
		if el < minimum:
			minimum = el
	return minimum

static func max(a:Array):
	if a.is_empty():
		return null
	var maximum = a[0]
	for el in a:
		if el > maximum:
			maximum = el
	return maximum

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

static func mean(a:Array) -> float:
	if a.is_empty():
		return 0.0
	return sum(a) / a.size()

# Set operations
static func union(a:Array, b:Array) -> Array:
	return distinct(a + b)

static func intersection(a:Array, b:Array) -> Array:
	var ret = []
	for el in a:
		if b.has(el) and !ret.has(el):
			ret.append(el)
	return ret

static func difference(a:Array, b:Array) -> Array:
	var ret = []
	for el in a:
		if !b.has(el):
			ret.append(el)
	return ret

# Array utilities
static func isEmpty(a:Array) -> bool:
	return a.is_empty()

static func isNotEmpty(a:Array) -> bool:
	return !a.is_empty()

static func count(a:Array) -> int:
	return a.size()

static func join(a:Array, separator:String = "") -> String:
	return separator.join(a)

static func concat(arrays:Array) -> Array:
	var ret = []
	for arr in arrays:
		ret.append_array(arr)
	return ret

# Object/Dictionary utilities
static func pluck(a:Array, key:String) -> Array:
	var ret = []
	for el in a:
		if el is Dictionary and el.has(key):
			ret.append(el[key])
	return ret

static func pick(d:Dictionary, key_list:Array) -> Dictionary:
	var ret = {}
	for key in key_list:
		if d.has(key):
			ret[key] = d[key]
	return ret

static func omit(d:Dictionary, key_list:Array) -> Dictionary:
	var ret = d.duplicate()
	for key in key_list:
		ret.erase(key)
	return ret

static func keys(d:Dictionary) -> Array:
	return d.keys()

static func values(d:Dictionary) -> Array:
	return d.values()

static func entries(d:Dictionary) -> Array:
	var ret = []
	for k in d:
		ret.append([k, d[k]])
	return ret

static func fromEntries(entry_list:Array) -> Dictionary:
	var ret = {}
	for entry in entry_list:
		ret[entry[0]] = entry[1]
	return ret

static func merge(a:Dictionary, b:Dictionary) -> Dictionary:
	var ret = a.duplicate()
	ret.merge(b)
	return ret

# Function utilities
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

static func repeat(value, n:int) -> Array:
	var ret = []
	for i in range(n):
		ret.append(value)
	return ret

static func times(n:int, fn:Callable) -> Array:
	var ret = []
	for i in range(n):
		ret.append(fn.call(i))
	return ret

static func tap(value, fn:Callable):
	fn.call(value)
	return value

static func identity(value):
	return value

static func constant(value) -> Callable:
	return func(): return value

# Function composition
static func compose(functions:Array) -> Callable:
	return func(x):
		var result = x
		for i in range(functions.size() - 1, -1, -1):
			result = functions[i].call(result)
		return result

static func pipe(functions:Array) -> Callable:
	return func(x):
		var result = x
		for fn in functions:
			result = fn.call(result)
		return result

static func partial(fn:Callable, bound_args:Array) -> Callable:
	return func(additional_args = []): 
		var all_args = bound_args.duplicate()
		if additional_args is Array:
			all_args.append_array(additional_args)
		else:
			all_args.append(additional_args)
		return fn.callv(all_args)