const fs = require('fs')
const { execSync } = require('child_process')

fs
.readdir(
	'./app',
	(
		error,
		filenames,
	) => {
		error
		&& (
			console
			.error(error)
		)

		const uploadCommands = (
			filenames
			.map(filename => (
				'nodemcu-tool upload --compile ./app/'
				.concat(filename)
			))
		)

		uploadCommands
		.forEach(command => {
			console
			.info(
				execSync(command)
				.toString()
			)
		})
	}
)
