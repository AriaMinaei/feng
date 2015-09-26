require! {
	'immutable': {fromJS: imm, Range: range}
	'./feng/pointfree'
	'./feng/helpers'
	'./Task': Task
	'data.maybe': Maybe
	'data.either': Either
}

deimm = (val) ->
	if val? and typeof val is \object
		imm(val).toJS!
	else
		val

module.exports = {imm, range, deimm}
module.exports <<< pointfree
module.exports <<< helpers
module.exports <<< {Task, Maybe, Either}