import UIKit
import SnapKit
import Then
import Moya

class ViewController: UIViewController {
    
    let provider = MoyaProvider<WeatherAPI>(plugins: [MoyaLoggingPlugin()])
    
    private let titleLabel = UILabel().then {
        $0.text = "DSM Weather"
        $0.font = .systemFont(ofSize: 35, weight: .bold)
    }
    
    private let weatherLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = .black
    }
    
    private let temperatureLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 80, weight: .heavy)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider.request(.weather) { result in
            switch result {
            case .success(let response):
                do {
                    let responseDate = try JSONDecoder().decode(Weather.self, from: response.data)
                    self.weatherLabel.text = responseDate.first?.weatherText ?? "No data"
                    self.temperatureLabel.text = "\(Double(responseDate.first?.temperature.metric.value ?? 0.00))°C" ?? "No data"
                    self.view.backgroundColor = UIColor(named: "\(responseDate.first?.weatherIcon ?? 1)")
                    print("\(responseDate.first?.weatherIcon)")
                } catch let error {
                    print("Decoding error: \(error)")
                }
            case .failure(let error):
                print("Network error: \(error)")
            }
        }
        
        getCurrentDateTime()
        attribute()
        add()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .systemGreen
    }

    private func add() {
        [
            titleLabel,
            dateLabel,
            weatherLabel,
            temperatureLabel,
        ].forEach{ view.addSubview($0) }
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let str = formatter.string(from: Date())
        dateLabel.text = "\(str)"
    }

}

