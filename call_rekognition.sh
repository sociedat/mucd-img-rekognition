for f in *.jpg; do
    arg='{"S3Object":{"Bucket":"mucd-rekognition-poc","Name":"'
    base=$(basename "${f}" '.jpg') # gives '25' from '25.conf'
    aws rekognition detect-labels --image "$arg$base.jpg\"}}" --region 'us-west-2' > "${base}".json
done
