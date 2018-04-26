const formidable = require('formidable');
const path = require('path');
const mkdirp = require('mkdirp');
const fs = require('fs');
const DEFAULT_UPLOAD_DIR = path.join(process.cwd(), '/tmp/fileuploads');

module.exports = (upload_directory) => {
	const upload_dir = upload_directory || DEFAULT_UPLOAD_DIR;

	if (!fs.existsSync(upload_dir)) {
		mkdirp.sync(upload_dir);
	}

	return (req, res, next) => {

		if (/(multipart\/form-data)/i.test(req.headers['content-type'])) {

			const body = {};
			const files = [];
			const form = new formidable.IncomingForm();
			form.uploadDir = upload_dir;

			form.on('field', function (field, value) {

				if (body[field] && Array.isArray(body[field])) {
					body[field].push(value);
				}
				else if (body[field]) {
					body[field] = [body[field]];
					body[field].push(value);
				}
				else {
					body[field] = value;
				}
			});

			form.on('error', function (err) {
				next(err);
			});

			form.on('file', function (name, file) {
				files.push({
					name: file.name,
					file: file
				});
			});

			form.on('end', function () {
				req.body = body;
				req.files = files;
				next();
			});

			form.parse(req);
		}
		else {
			next();
		}
	};
};
