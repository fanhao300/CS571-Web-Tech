from flask import (Flask, request)
from flask.json import jsonify
import util

# EB looks for an 'application' callable by default.
application = Flask(__name__)

@application.route('/') 
def homepage():
    return application.send_static_file("index.html")


@application.route('/api/stock', methods=('GET',))
def stock_request():
    stock_name = request.args.get("stock", None)
    if stock_name is None:
        pass
    else:
        info = util.get_company_inf(stock_name)
        if "detail" in info.keys() and info["detail"] == "Not found." :
            return jsonify({'info': info})
        else:
            try:
                ticker = util.get_company_stock(stock_name)
                news = util.get_company_news(stock_name)
                trend = util.get_company_stock_trend(stock_name)
            except:
                info = {
                    "detail" : "Not found."
                }
                return jsonify({'info': info})
            return jsonify({'ticker': ticker, 'info': info, 'news': news, 'trend': trend})

# run the app.
if __name__ == "__main__":
    # Setting debug to True enables debug output. This line should be
    # removed before deploying a production app.
    application.debug = True
    application.run()