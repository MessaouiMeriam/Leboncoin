import Foundation
import UIKit

class TabsView: UIView {
    
    
    // MARK: Variables
    private let defaultFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
    private var tabs = [CategoryViewModel]()
    private var selectedTab = -1
    private var buttonsArray = [UIButton]()
    private let selectionBarHeight: CGFloat = 2.0
    private let buttonsSapicing:CGFloat = 10.0
    private var selectionColor = UIColor()
    
    
    private lazy var selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = selectionColor
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: bounds)
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    
    var didSelectTab: ((Int) ->())?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    init(tabs tabsArray: [CategoryViewModel], selectedTabIndex index: Int = 0, selectionHandler: ((Int) ->())? = nil) {
        super.init(frame: defaultFrame)
        tabs = tabsArray
        didSelectTab = selectionHandler
        setupView()
        selectTab(at: index)
    }
    
    func load(tabs tabsArray: [CategoryViewModel], selectedTabIndex index: Int = 0, seletionColor color: UIColor, selectionHandler: ((Int) ->())? = nil) {
        tabs = tabsArray
        selectionColor = color
        setupView()
        selectTab(at: index)
        didSelectTab = selectionHandler
    }
    
    // MARK: Private
    private func setupView() {
        
        // no tabs, no need to continue
        if tabs.count == 0 { return }
        buttonsArray.removeAll()
        
        for i in 0..<tabs.count {
            let button = UIButton(type: .custom)
            button.tag = i
            button.setTitle(tabs[i].name, for: .normal)
            button.addTarget(self, action: #selector(tabBtnPressed(tab:)), for: .touchUpInside)
            button.titleLabel?.textAlignment = .center
            button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 15.0)
            buttonsArray.append(button)
            updateStyle(tabIndex: i)
        }
        
        addSubview(scrollView)
        scrollView.setAnchors(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        let stackView = UIStackView(arrangedSubviews: buttonsArray)
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = buttonsSapicing

        scrollView.addSubview(stackView)
        
        // add constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setAnchors(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor)
        stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        stackView.insertSubview(selectionView, at: 0)
        selectionView.layer.cornerRadius = frame.height / 2
        buttonsArray.forEach {
            $0.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        }
        layoutIfNeeded()
    }
    
    private func updateStyle(tabIndex: Int) {
        
        if tabIndex == selectedTab {
            buttonsArray[tabIndex].setTitleColor(AppStyle.Color.black, for: .normal)
            buttonsArray[tabIndex].titleLabel?.font = AppStyle.Font.openSansMedium(size: 14).font
            buttonsArray[tabIndex].layer.borderWidth = 0
        } else {
            buttonsArray[tabIndex].setTitleColor(AppStyle.Color.black, for: .normal)
            buttonsArray[tabIndex].layer.borderWidth = 1
            buttonsArray[tabIndex].layer.borderColor = AppStyle.Color.lightGray.cgColor
            buttonsArray[tabIndex].layer.cornerRadius = frame.height / 2
            buttonsArray[tabIndex].titleLabel?.font =  AppStyle.Font.openSansMedium(size: 14).font
        }
        
    }
    
    @objc private func tabBtnPressed(tab: UIButton) {
        selectTab(at: tab.tag)
    }
    
    func selectTab(at index: Int) {
        if selectedTab == index {
            return
        }
        selectedTab = index
        didSelectTab?(self.selectedTab)
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: []) {[weak self] in
            guard let self = self else {
                return
            }
            self.selectionView.frame = CGRect(x: self.buttonsArray[self.selectedTab].frame.origin.x,
                                              y: 0 ,
                                              width: self.buttonsArray[self.selectedTab].frame.width,
                                              height: self.frame.size.height)
            self.scrollView.scrollRectToVisible(self.buttonsArray[self.selectedTab].frame.insetBy(dx: -3 * self.buttonsSapicing, dy: 0), animated: false)
        }
        
        for i in 0..<buttonsArray.count {
            updateStyle(tabIndex: i)
        }
        
    }
}
