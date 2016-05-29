package com.framework.types {
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class PostRequest {
		protected var _main_boundary;
		protected var _array_form_data : Object;
		protected var _array_file_data : Object;

		// Constructor
		public function PostRequest() {
			_main_boundary = getBoundary();
			_array_form_data = new Object();
			_array_file_data = new Object();
		}

		// Add a Property
		public function addFormData(form_name : String, data : String) {
			_array_form_data[form_name] = data;
		}

		// Add a File
		public function addFileData(form_name : String, file_name : String, data : ByteArray, content_type : String = "image/png") {
			if (!_array_file_data[form_name]) {
				_array_file_data[form_name] = new Object();
			}
			_array_file_data[form_name][file_name] = new Object();
			_array_file_data[form_name][file_name].type = content_type;
			_array_file_data[form_name][file_name].data = data;
		}

		protected function getBoundary() : String {
			var _boundary = "---------------------------";
			if (_boundary.length == 0) {
				for (var i : int = 0; i < 0x10; i++ ) {
					_boundary += String.fromCharCode(int(97 + Math.random() * 25));
				}
			}

			return _boundary;
		}

		public function getURLRequest(url : String) : URLRequest {
			var _request = new URLRequest();
			_request.url = url;
			_request.method = URLRequestMethod.POST;
			_request.contentType = getContentType();
			_request.data = getPostData();

			return _request;
		}

		public function getContentType() : String {
			return 'multipart/form-data; boundary=' + _main_boundary;
		}

		public function getPostData() : ByteArray {
			var _form_name : String;
			var _file_name : String;
			var _boundary : String;
			var _content_type : String;
			var _data : ByteArray;

			var _post_data : ByteArray;
			_post_data = new ByteArray();
			_post_data.endian = Endian.BIG_ENDIAN;

			// 속성 추가
			for (_form_name in _array_form_data) {
				_post_data = writeBoundary(_post_data, _main_boundary);
				_post_data = writeLineBreak(_post_data);
				_post_data = writeString(_post_data, 'Content-Disposition: form-data; name="' + _form_name + '"');
				_post_data = writeLineBreak(_post_data);
				_post_data = writeLineBreak(_post_data);
				_post_data.writeUTFBytes(_array_form_data[_form_name]);
				_post_data = writeLineBreak(_post_data);
			}

			// 파일 추가
			for (_form_name in _array_file_data) {
				for (_file_name in _array_file_data[_form_name]) {
					_content_type = _array_file_data[_form_name][_file_name].type;
					_data = _array_file_data[_form_name][_file_name].data;

					_post_data = writeBoundary(_post_data, _main_boundary);
					_post_data = writeLineBreak(_post_data);
					_post_data = writeString(_post_data, 'Content-Disposition: form-data; name="' + _form_name + '"; filename="' + _file_name + '"');
					_post_data = writeLineBreak(_post_data);
					_post_data = writeString(_post_data, 'Content-Type: application/octet-stream');
					_post_data = writeLineBreak(_post_data);
					_post_data = writeLineBreak(_post_data);
					_post_data.writeBytes(_data, 0, _data.length);
					_post_data = writeLineBreak(_post_data);
				}
			}

			// 닫기
			_post_data = writeBoundary(_post_data, _main_boundary);
			_post_data = writeDoubleDash(_post_data);
			_post_data = writeLineBreak(_post_data);

			return _post_data;
		}

		// 바이너리에 문자열 쓰기
		protected function writeString(_post_data : ByteArray, str : String) : ByteArray {
			for (var i : int = 0; i < str.length; i++ ) {
				_post_data.writeByte(str.charCodeAt(i));
			}

			return _post_data
		}

		// 바이너리에 바운더리 쓰기
		protected function writeBoundary(_post_data : ByteArray, _boundary : String) : ByteArray {
			_post_data = writeDoubleDash(_post_data);
			writeString(_post_data, _boundary);

			return _post_data;
		}

		// 바이너리에 라인 쓰기
		protected function writeLineBreak(_post_data : ByteArray) : ByteArray {
			_post_data.writeShort(0x0d0a);
			return _post_data;
		}

		// 바이너리에 "--" 쓰기
		protected function writeDoubleDash(_post_data : ByteArray) : ByteArray {
			_post_data.writeShort(0x2d2d);
			return _post_data;
		}
	}
}