require! {
	'./feng': {createTask}
}

module.exports =
	# String -> Task (Either Error Object)
	getItem: (key) ->
		createTask (reject, resolve) ->
			val = localStorage.getItem key
			if val?
				resolve val
			else
				reject new Error "Key doesn't exist in localStorage"
