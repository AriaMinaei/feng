require! {
	'control.async': async
	'../Task': Task
}

module.exports = do
	identity: (a) ->
		a

	map: (fn, functor) -->
		functor.map fn

	chain: chain = (fn, monad) -->
		monad.chain fn

	inspect: (tag, functor) -->
		logRight = (val) ->
			console.log 'Right |', tag, val
			val

		logFail = (val) ->
			console.log 'Left  |', tag, val
			val

		functor.bimap logFail, logRight

	constant: (val) -> -> val

	filter: (predicate, obj) -->
		obj.filter predicate

	some: (predicate, obj) -->
		obj.some predicate

	reduce: reduce = (fn, initial, obj) -->
		obj.reduce fn, initial

	concat: (s, a) -->
		a.concat s

	last: (a) ->
		a.last!

	first: (a) ->
		a.first!

	takeWhile: (fn, obj) -->
		obj.takeWhile fn

	fork: (onErr, onResolve, task) -->
		task.fork onErr, onResolve

	tap: (fn, val) -->
		fn val
		val

	cata: (pattern, obj) -->
		obj.cata pattern

	bimap: (f, g, obj) -->
		obj.bimap f, g

	orElse: (f, obj) -->
		obj.orElse f

	leftMap: (f, obj) -->
		obj.leftMap f

	rejectedMap: (f, obj) -->
		obj.rejectedMap f

	fold: (f, g, obj) -->
		obj.fold f, g

	sequenceTaskFns: (fns, acc) -->
		runFn = (fn, lastTask) ->
			lastTask |> chain fn

		reduce runFn, acc, fns

	bimapSame: (fn, functor) ->
		functor.bimap fn, fn

	cataChain: (pattern, chainable) ->
		functor.cataChain pattern

module.exports{parallel, timeout: timeoutTask, liftNode} = async Task