{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "61bc3a5b",
   "metadata": {
    "papermill": {
     "duration": 0.00267,
     "end_time": "2023-11-18T13:45:22.085131",
     "exception": false,
     "start_time": "2023-11-18T13:45:22.082461",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Regresyon Uygulama 1 - Train ve Test Ayırma"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "6ed6d4e1",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2023-11-18T13:45:22.095428Z",
     "iopub.status.busy": "2023-11-18T13:45:22.092522Z",
     "iopub.status.idle": "2023-11-18T13:45:22.500310Z",
     "shell.execute_reply": "2023-11-18T13:45:22.497417Z"
    },
    "papermill": {
     "duration": 0.416122,
     "end_time": "2023-11-18T13:45:22.503669",
     "exception": false,
     "start_time": "2023-11-18T13:45:22.087547",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 21</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>id</th><th scope=col>date</th><th scope=col>price</th><th scope=col>bedrooms</th><th scope=col>bathrooms</th><th scope=col>sqft_living</th><th scope=col>sqft_lot</th><th scope=col>floors</th><th scope=col>waterfront</th><th scope=col>view</th><th scope=col>⋯</th><th scope=col>grade</th><th scope=col>sqft_above</th><th scope=col>sqft_basement</th><th scope=col>yr_built</th><th scope=col>yr_renovated</th><th scope=col>zipcode</th><th scope=col>lat</th><th scope=col>long</th><th scope=col>sqft_living15</th><th scope=col>sqft_lot15</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>7129300520</td><td>20141013T000000</td><td> 221900</td><td>3</td><td>1.00</td><td>1180</td><td>  5650</td><td>1</td><td>0</td><td>0</td><td>⋯</td><td> 7</td><td>1180</td><td>   0</td><td>1955</td><td>   0</td><td>98178</td><td>47.5112</td><td>-122.257</td><td>1340</td><td>  5650</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>6414100192</td><td>20141209T000000</td><td> 538000</td><td>3</td><td>2.25</td><td>2570</td><td>  7242</td><td>2</td><td>0</td><td>0</td><td>⋯</td><td> 7</td><td>2170</td><td> 400</td><td>1951</td><td>1991</td><td>98125</td><td>47.7210</td><td>-122.319</td><td>1690</td><td>  7639</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>5631500400</td><td>20150225T000000</td><td> 180000</td><td>2</td><td>1.00</td><td> 770</td><td> 10000</td><td>1</td><td>0</td><td>0</td><td>⋯</td><td> 6</td><td> 770</td><td>   0</td><td>1933</td><td>   0</td><td>98028</td><td>47.7379</td><td>-122.233</td><td>2720</td><td>  8062</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2487200875</td><td>20141209T000000</td><td> 604000</td><td>4</td><td>3.00</td><td>1960</td><td>  5000</td><td>1</td><td>0</td><td>0</td><td>⋯</td><td> 7</td><td>1050</td><td> 910</td><td>1965</td><td>   0</td><td>98136</td><td>47.5208</td><td>-122.393</td><td>1360</td><td>  5000</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1954400510</td><td>20150218T000000</td><td> 510000</td><td>3</td><td>2.00</td><td>1680</td><td>  8080</td><td>1</td><td>0</td><td>0</td><td>⋯</td><td> 8</td><td>1680</td><td>   0</td><td>1987</td><td>   0</td><td>98074</td><td>47.6168</td><td>-122.045</td><td>1800</td><td>  7503</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>7237550310</td><td>20140512T000000</td><td>1225000</td><td>4</td><td>4.50</td><td>5420</td><td>101930</td><td>1</td><td>0</td><td>0</td><td>⋯</td><td>11</td><td>3890</td><td>1530</td><td>2001</td><td>   0</td><td>98053</td><td>47.6561</td><td>-122.005</td><td>4760</td><td>101930</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 21\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & id & date & price & bedrooms & bathrooms & sqft\\_living & sqft\\_lot & floors & waterfront & view & ⋯ & grade & sqft\\_above & sqft\\_basement & yr\\_built & yr\\_renovated & zipcode & lat & long & sqft\\_living15 & sqft\\_lot15\\\\\n",
       "  & <dbl> & <chr> & <dbl> & <int> & <dbl> & <int> & <int> & <dbl> & <int> & <int> & ⋯ & <int> & <int> & <int> & <int> & <int> & <int> & <dbl> & <dbl> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 7129300520 & 20141013T000000 &  221900 & 3 & 1.00 & 1180 &   5650 & 1 & 0 & 0 & ⋯ &  7 & 1180 &    0 & 1955 &    0 & 98178 & 47.5112 & -122.257 & 1340 &   5650\\\\\n",
       "\t2 & 6414100192 & 20141209T000000 &  538000 & 3 & 2.25 & 2570 &   7242 & 2 & 0 & 0 & ⋯ &  7 & 2170 &  400 & 1951 & 1991 & 98125 & 47.7210 & -122.319 & 1690 &   7639\\\\\n",
       "\t3 & 5631500400 & 20150225T000000 &  180000 & 2 & 1.00 &  770 &  10000 & 1 & 0 & 0 & ⋯ &  6 &  770 &    0 & 1933 &    0 & 98028 & 47.7379 & -122.233 & 2720 &   8062\\\\\n",
       "\t4 & 2487200875 & 20141209T000000 &  604000 & 4 & 3.00 & 1960 &   5000 & 1 & 0 & 0 & ⋯ &  7 & 1050 &  910 & 1965 &    0 & 98136 & 47.5208 & -122.393 & 1360 &   5000\\\\\n",
       "\t5 & 1954400510 & 20150218T000000 &  510000 & 3 & 2.00 & 1680 &   8080 & 1 & 0 & 0 & ⋯ &  8 & 1680 &    0 & 1987 &    0 & 98074 & 47.6168 & -122.045 & 1800 &   7503\\\\\n",
       "\t6 & 7237550310 & 20140512T000000 & 1225000 & 4 & 4.50 & 5420 & 101930 & 1 & 0 & 0 & ⋯ & 11 & 3890 & 1530 & 2001 &    0 & 98053 & 47.6561 & -122.005 & 4760 & 101930\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 21\n",
       "\n",
       "| <!--/--> | id &lt;dbl&gt; | date &lt;chr&gt; | price &lt;dbl&gt; | bedrooms &lt;int&gt; | bathrooms &lt;dbl&gt; | sqft_living &lt;int&gt; | sqft_lot &lt;int&gt; | floors &lt;dbl&gt; | waterfront &lt;int&gt; | view &lt;int&gt; | ⋯ ⋯ | grade &lt;int&gt; | sqft_above &lt;int&gt; | sqft_basement &lt;int&gt; | yr_built &lt;int&gt; | yr_renovated &lt;int&gt; | zipcode &lt;int&gt; | lat &lt;dbl&gt; | long &lt;dbl&gt; | sqft_living15 &lt;int&gt; | sqft_lot15 &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 7129300520 | 20141013T000000 |  221900 | 3 | 1.00 | 1180 |   5650 | 1 | 0 | 0 | ⋯ |  7 | 1180 |    0 | 1955 |    0 | 98178 | 47.5112 | -122.257 | 1340 |   5650 |\n",
       "| 2 | 6414100192 | 20141209T000000 |  538000 | 3 | 2.25 | 2570 |   7242 | 2 | 0 | 0 | ⋯ |  7 | 2170 |  400 | 1951 | 1991 | 98125 | 47.7210 | -122.319 | 1690 |   7639 |\n",
       "| 3 | 5631500400 | 20150225T000000 |  180000 | 2 | 1.00 |  770 |  10000 | 1 | 0 | 0 | ⋯ |  6 |  770 |    0 | 1933 |    0 | 98028 | 47.7379 | -122.233 | 2720 |   8062 |\n",
       "| 4 | 2487200875 | 20141209T000000 |  604000 | 4 | 3.00 | 1960 |   5000 | 1 | 0 | 0 | ⋯ |  7 | 1050 |  910 | 1965 |    0 | 98136 | 47.5208 | -122.393 | 1360 |   5000 |\n",
       "| 5 | 1954400510 | 20150218T000000 |  510000 | 3 | 2.00 | 1680 |   8080 | 1 | 0 | 0 | ⋯ |  8 | 1680 |    0 | 1987 |    0 | 98074 | 47.6168 | -122.045 | 1800 |   7503 |\n",
       "| 6 | 7237550310 | 20140512T000000 | 1225000 | 4 | 4.50 | 5420 | 101930 | 1 | 0 | 0 | ⋯ | 11 | 3890 | 1530 | 2001 |    0 | 98053 | 47.6561 | -122.005 | 4760 | 101930 |\n",
       "\n"
      ],
      "text/plain": [
       "  id         date            price   bedrooms bathrooms sqft_living sqft_lot\n",
       "1 7129300520 20141013T000000  221900 3        1.00      1180          5650  \n",
       "2 6414100192 20141209T000000  538000 3        2.25      2570          7242  \n",
       "3 5631500400 20150225T000000  180000 2        1.00       770         10000  \n",
       "4 2487200875 20141209T000000  604000 4        3.00      1960          5000  \n",
       "5 1954400510 20150218T000000  510000 3        2.00      1680          8080  \n",
       "6 7237550310 20140512T000000 1225000 4        4.50      5420        101930  \n",
       "  floors waterfront view ⋯ grade sqft_above sqft_basement yr_built yr_renovated\n",
       "1 1      0          0    ⋯  7    1180          0          1955        0        \n",
       "2 2      0          0    ⋯  7    2170        400          1951     1991        \n",
       "3 1      0          0    ⋯  6     770          0          1933        0        \n",
       "4 1      0          0    ⋯  7    1050        910          1965        0        \n",
       "5 1      0          0    ⋯  8    1680          0          1987        0        \n",
       "6 1      0          0    ⋯ 11    3890       1530          2001        0        \n",
       "  zipcode lat     long     sqft_living15 sqft_lot15\n",
       "1 98178   47.5112 -122.257 1340            5650    \n",
       "2 98125   47.7210 -122.319 1690            7639    \n",
       "3 98028   47.7379 -122.233 2720            8062    \n",
       "4 98136   47.5208 -122.393 1360            5000    \n",
       "5 98074   47.6168 -122.045 1800            7503    \n",
       "6 98053   47.6561 -122.005 4760          101930    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "kc_house_data = read.csv(\"/kaggle/input/kc-house-data/kc_house_data.csv\")\n",
    "head(kc_house_data)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "19a79775",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-11-18T13:45:22.595726Z",
     "iopub.status.busy": "2023-11-18T13:45:22.510726Z",
     "iopub.status.idle": "2023-11-18T13:45:22.757314Z",
     "shell.execute_reply": "2023-11-18T13:45:22.755371Z"
    },
    "papermill": {
     "duration": 0.253837,
     "end_time": "2023-11-18T13:45:22.760165",
     "exception": false,
     "start_time": "2023-11-18T13:45:22.506328",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>price</th><th scope=col>sqft_living</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td> 221900</td><td>1180</td></tr>\n",
       "\t<tr><th scope=row>2</th><td> 538000</td><td>2570</td></tr>\n",
       "\t<tr><th scope=row>3</th><td> 180000</td><td> 770</td></tr>\n",
       "\t<tr><th scope=row>4</th><td> 604000</td><td>1960</td></tr>\n",
       "\t<tr><th scope=row>5</th><td> 510000</td><td>1680</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1225000</td><td>5420</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & price & sqft\\_living\\\\\n",
       "  & <dbl> & <int>\\\\\n",
       "\\hline\n",
       "\t1 &  221900 & 1180\\\\\n",
       "\t2 &  538000 & 2570\\\\\n",
       "\t3 &  180000 &  770\\\\\n",
       "\t4 &  604000 & 1960\\\\\n",
       "\t5 &  510000 & 1680\\\\\n",
       "\t6 & 1225000 & 5420\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 2\n",
       "\n",
       "| <!--/--> | price &lt;dbl&gt; | sqft_living &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| 1 |  221900 | 1180 |\n",
       "| 2 |  538000 | 2570 |\n",
       "| 3 |  180000 |  770 |\n",
       "| 4 |  604000 | 1960 |\n",
       "| 5 |  510000 | 1680 |\n",
       "| 6 | 1225000 | 5420 |\n",
       "\n"
      ],
      "text/plain": [
       "  price   sqft_living\n",
       "1  221900 1180       \n",
       "2  538000 2570       \n",
       "3  180000  770       \n",
       "4  604000 1960       \n",
       "5  510000 1680       \n",
       "6 1225000 5420       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "17290"
      ],
      "text/latex": [
       "17290"
      ],
      "text/markdown": [
       "17290"
      ],
      "text/plain": [
       "[1] 17290"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "4323"
      ],
      "text/latex": [
       "4323"
      ],
      "text/markdown": [
       "4323"
      ],
      "text/plain": [
       "[1] 4323"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "model_data <- kc_house_data[c(\"price\" ,\"sqft_living\")]\n",
    "\n",
    "head(model_data)\n",
    "\n",
    "# random sample \n",
    "\n",
    "set.seed(145)\n",
    "sampleIndex <- sample(1:nrow(model_data) , size = 0.8*nrow(model_data))\n",
    "\n",
    "trainSet <- model_data[sampleIndex , ]\n",
    "testSet <- model_data[-sampleIndex , ]\n",
    "\n",
    "nrow(trainSet)\n",
    "nrow(testSet)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "a43561f8",
   "metadata": {
    "papermill": {
     "duration": 0.003269,
     "end_time": "2023-11-18T13:45:22.766801",
     "exception": false,
     "start_time": "2023-11-18T13:45:22.763532",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [
    {
     "datasetId": 30990,
     "sourceId": 39532,
     "sourceType": "datasetVersion"
    }
   ],
   "dockerImageVersionId": 30582,
   "isGpuEnabled": false,
   "isInternetEnabled": true,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 4.474624,
   "end_time": "2023-11-18T13:45:22.891966",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-11-18T13:45:18.417342",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
