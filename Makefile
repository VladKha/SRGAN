make_virtualenv:
	@echo "Creating virtualenv..."
	python3 -m venv .venv							; \
	source .venv/bin/activate

install_dependencies:
	@echo "Installing dependencies..."
	pip install --upgrade pip
	pip install -r requirements.txt

download_models:
	@echo "Downloading models..."
	mkdir models
	cd models										; \
	gdown --id 1CLw6Cn3yNI1N15HyX99_Zy9QnDcgP3q7	; \
	gdown --id 1GlU9At-5XEDilgnt326fyClvZB_fsaFZ	; \
	gdown --id 1RpOtVcVK-yxnVhNH4KSjnXHDvuU_pq3j	; \
	mv srgan-g-tensorflow.npz g.npz					; \
	mv srgan-d-tensorflow.npz d.npz					; \
	cd ..											; \
	mkdir model										; \
	cp models/vgg19.npy model

# only needed for training/validation
#download_data:
#	mkdir DIV2K
#	cd DIV2K
#	wget https://data.vision.ee.ethz.ch/cvl/DIV2K/validation_release/DIV2K_test_LR_bicubic_X4.zip
#	wget https://data.vision.ee.ethz.ch/cvl/DIV2K/DIV2K_train_HR.zip
#	wget https://data.vision.ee.ethz.ch/cvl/DIV2K/DIV2K_train_LR_bicubic_X4.zip
#	wget https://data.vision.ee.ethz.ch/cvl/DIV2K/validation_release/DIV2K_valid_HR.zip
#	wget https://data.vision.ee.ethz.ch/cvl/DIV2K/DIV2K_valid_LR_bicubic_X4.zip
#	unzip DIV2K_test_LR_bicubic_X4.zip
#	unzip DIV2K_train_HR.zip
#	unzip DIV2K_train_LR_bicubic_X4.zip
#	unzip DIV2K_valid_HR.zip
#	unzip DIV2K_valid_LR_bicubic_X4.zip

predict:
	@echo "Predicting test images..."
	python train.py --mode=predict --predict-dir-path=test_images

all: make_virtualenv install_dependencies download_models predict
