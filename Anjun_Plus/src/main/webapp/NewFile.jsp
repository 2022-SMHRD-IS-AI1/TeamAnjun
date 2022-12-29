<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
.modal_wrap {
	display: none;
	width: 500px;
	height: 500px;
	position: absolute;
	top: 50%;
	left: 50%;
	margin: -250px 0 0 -250px;
	background: #eee;
	z-index: 2;
}

.black_bg {
	display: none;
	position: absolute;
	content: "";
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	top: 0;
	left: 0;
	z-index: 1;
}

.modal_close {
	width: 26px;
	height: 26px;
	position: absolute;
	top: -30px;
	right: 0;
}

.modal_close>a {
	display: block;
	width: 100%;
	height: 100%;
	background: url(https://img.icons8.com/metro/26/000000/close-window.png);
	text-indent: -9999px; < style >html, body { margin : 0;
	padding: 0;
}

#divCanvas {
	position: relative;
	padding: 5rem;
	display: inline-block;
	width: 40%;
	height: 200px;
}

#divCanvas canvas {
	position: absolute;
	display: inline-block;
	background-color: aliceblue";
	width
	="500"
	height="300";
}

#divCanvas #canvas {
	z-index: 1;
}

#divCanvas #mosaic {
	z-index: 2;
}

#divCanvas #hover {
	z-index: 3;
}
}
</style>
<body>
	<button type='button' id="modal_btn">모자이크 처리</button>
	<div class="black_bg"></div>
	<div class="modal_wrap">
		<div class="modal_close">
			<a href="#">close</a>
		</div>
		<div>
			<section>
				<div id="divCanvas">
					<canvas id="canvas"></canvas>
					<!--원본-->
					<canvas id="mosaic"></canvas>
					<!--모자이크 영역-->
					<canvas id="hover"></canvas>
					<!--마우스영역-->
				</div>
				<button type="button" id="btnMosaic">모자이크</button>
				<button type="button" id="btnEraser">지우개</button>
				<button type="button" id="btnSave">저장하기</button>
			</section>
		</div>
	</div>


	<script>
		window.onload = function() {

			function onClick() {
				document.querySelector('.modal_wrap').style.display = 'block';
				document.querySelector('.black_bg').style.display = 'block';
			}
			function offClick() {
				document.querySelector('.modal_wrap').style.display = 'none';
				document.querySelector('.black_bg').style.display = 'none';
			}

			document.getElementById('modal_btn').addEventListener('click',
					onClick);
			document.querySelector('.modal_close').addEventListener('click',
					offClick);

		};

		let isMozaic = false;

		/* canvas setting*/
		const canvas = document.getElementById('canvas');
		const ctx = canvas.getContext('2d');

		/* 이미지 가져오기 */
		let img = new Image()
		img.src = "SampleImg.jpg"
		img.onload = function() {
			ctx.clearRect(0, 0, canvas.width, canvas.height);
			ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

			mosaicCtx = document.getElementById('mosaic').getContext('2d');
			mosaicCtx.clearRect(0, 0, canvas.width, canvas.height);
			mosaicCtx.drawImage(img, 0, 0, canvas.width, canvas.height);
		};

		/* event */
		document.getElementById('hover').addEventListener('mousemove',
				function(e) {
					/* 사각형 영역 만들기 */
					var x = event.clientX - ctx.canvas.offsetLeft - 15;
					var y = event.clientY - ctx.canvas.offsetTop - 15;

					x = x < 0 ? 0 : x;
					y = y < 0 ? 0 : y;

					ctxHover = this.getContext('2d');
					ctxHover.clearRect(0, 0, this.width, this.height)

					ctxHover.strokeStyle = 'black';
					ctxHover.strokeWidth = 3;
					ctxHover.fillStyle = 'rgba(255, 255, 255, 0.5)';

					ctxHover.fillRect(x, y, 30, 30);
				});

		document.getElementById('hover').addEventListener('mouseout',
				function(e) {
					/* 사각형 지우기 */
					ctxHover = this.getContext('2d');
					ctxHover.clearRect(0, 0, this.width, this.height);
				});

		document.getElementById('hover').addEventListener('click', function(e) {
			/* 사각형 영역만큼 처리 */
			var x = event.clientX - ctx.canvas.offsetLeft - 15;
			var y = event.clientY - ctx.canvas.offsetTop - 15;

			x = x < 0 ? 0 : x;
			y = y < 0 ? 0 : y;

			mosaic = document.getElementById('mosaic');
			mosaicCtx = mosaic.getContext('2d');
			var imageData = ctx.getImageData(x, y, 40, 40);
			if (isMozaic) {
				/* 모자이크 */
				for (var i = 0; i < imageData.data.length; i = i + 4) {
					r = imageData.data[i];
					g = imageData.data[i + 1];
					b = imageData.data[i + 2];
					a = imageData.data[i + 3];
					for (var j = 1; j <= 9; j++) {
						imageData.data[i + 4] = r;
						imageData.data[i + 5] = g;
						imageData.data[i + 6] = b;
						imageData.data[i + 7] = a;
						i = i + 4;
					}
				}

			}
			mosaicCtx.putImageData(imageData, x, y);
		})

		/* btn */
		document.getElementById("btnMosaic").onclick = function() {
			isMozaic = true;
		};

		document.getElementById("btnEraser").onclick = function() {
			isMozaic = false;
		};

		document.getElementById("btnSave").onclick = function(e) {
			mosaic = document.getElementById('mosaic');
			image = mosaic.toDataURL("image/png", 1.0).replace("image/png",
					"image/octet-stream");
			var link = document.createElement('a');
			link.download = "mozaic.png";
			link.href = image;
			link.click();
		};
	</script>
</body>
</html>