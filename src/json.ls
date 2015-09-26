require! {
	'./feng': {eitherify}
}

module.exports =
	parse: eitherify JSON.parse
	stringify: eitherify JSON.stringify