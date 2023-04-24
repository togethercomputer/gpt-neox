# list all files under /root/ft_data/OIG/ that ends with jsonl

yourfilenames=`ls /root/ft_data/OIG/*.jsonl`
for eachfile in $yourfilenames
do
    filename=$(basename -- "$eachfile")
    extension="${filename##*.}"
    filename="${filename%.*}"
    mkdir -p /root/ft_data/OIG/tokenized/$filename/
    python tools/preprocess_data.py \
            --input $eachfile \
            --jsonl-keys "text" \
            --output-prefix /root/ft_data/OIG/tokenized/$filename/ \
            --vocab-file /root/ft_data/meta/20B_tokenizer.json \
            --dataset-impl mmap \
            --tokenizer-type HFTokenizer \
            --append-eod \
            --workers 20 &
done

# python tools/preprocess_data.py \
#            --input /root/ft_data/OIG/unified_p3.jsonl \
#            --jsonl-keys "text" \
#            --output-prefix /root/ft_data/OIG/tokenized/unified_p3 \
#            --vocab-file /root/ft_data/meta/20B_tokenizer.json \
#            --dataset-impl mmap \
#            --tokenizer-type HFTokenizer \
#            --append-eod \
#            --workers 120
