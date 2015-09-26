require! {
	'data.either': Either
	'../Task': Task
}

module.exports =
	createTask: createTask = (fn, cleanup) ->
		nonReturningFn = !-> fn.apply null, arguments
		new Task nonReturningFn, cleanup

	eitherify: eitherify = (fn) -> ->
		try
			val = fn ...arguments

		catch e

		if val?
			Either.Right val
		else
			Either.Left e

	promiseFnToTask: promiseFnToTask = (fn) ->
		createTask (reject, resolve) !->
			fn().then resolve, reject

	promiseToTask: (p) ->
		createTask (reject, resolve) !->
			p.done resolve, reject

	timeoutAsTask: timeoutAsTask = (ms, error = "Timed out") ->
		createTask (reject, resolve) !->
			setTimeout !->
				reject new Error error
			, ms

	delayAsTask: (ms) ->
		createTask (_, resolve) ->
			setTimeout resolve, ms

	dummyTask: dummyTask = (fn) ->
		createTask (reject, resolve) !->
			fn!
			resolve!

	tryAsTask: tryAsTask = (fn) ->
		createTask (reject, resolve) ->
			success = yes
			try
				ret =  fn!
			catch e
				success = no

			if success
				resolve ret
			else
				reject e


	fnToTaskFn: (fn) ->
		# console.trace 'ffsff'
		# console.log fn
		(...args) ->
			tryAsTask (-> fn ...args)

	eitherToTask: eitherToTask = (e) ->
		e.cata do
			Left: -> Task.rejected &0
			Right: -> Task.of &0

	eitherFnToTaskFn: eitherFnToTaskFn = (fn) -> ->
		fn ...arguments
		|> eitherToTask