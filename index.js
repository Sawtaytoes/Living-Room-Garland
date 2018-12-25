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
			[
				'nodemcu-tool upload --minify ./app/init.lua'
			]
			.concat(
				filenames
				.filter(filename => (
					filename !== 'init.lua'
				))
				.map(filename => (
					'nodemcu-tool upload --minify ./app/'
					.concat(filename)
				))
			)
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
