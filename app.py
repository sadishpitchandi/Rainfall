from flask import Flask ,render_template, request
import pandas as pd

app=Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def index():
    try:
        return render_template('index.html')
    except Exception as e:
        return str(e)  



@app.route('/predict', methods=['GET', 'POST'])
def predict():

   
      
    data=pd.read_csv(r"data\\CHENNAI\\CH_NUNGAMBAKKAM.csv")
    
    
    # html = data.to_html()
    #print(html)
    
    if request.method == 'POST':
           data = request.form['data']
    context = {
             'data':data
        }
    
    return render_template("predict.html", context=context)

    
    # return render_template('header.html', context=context)
"""
@app.route('/meenabakkamfile', methods=['GET', 'POST'])
def predict():

    data=pd.read_csv(r"data\\CHENNAI\\CH_MEENAMBAKKAM.csv")
    
    
    html = data.to_html()
    
    
    if request.method == 'POST':
           data = request.form['data']
    context = {
             'data':data
        }
    
    return render_template("predict.html", context=context)

    """

"""
@app.route('/extractoftime', methods=['GET', 'POST'])
def extractoftime():
    try:


      
        

        return render_template('index.HTML')
    except Exception as e:
        return str(e)  

"""



if __name__=="__main__":
    app.run(debug=True)