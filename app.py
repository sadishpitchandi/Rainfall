from flask import Flask ,render_template
import pandas as pd

app=Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def index():
    try:
        return render_template('index.HTML')
    except Exception as e:
        return str(e)


@app.route('/predict', methods=['GET', 'POST'])
def predict():

    context = {
        data: None
    }
      
    data=pd.read_csv("C:\sadish\project\machine learning\Rainfall\work\CHENNAI\CH_NUNGAMBAKKAM.csv")
    return data
    data=data
    

    if request.method == 'POST':
    age = int(request.form['age'])



 
    context = {
             data:data
        }

    
    return render_template('header.html', context=context)









if __name__=="__main__":
    app.run(debug=True)