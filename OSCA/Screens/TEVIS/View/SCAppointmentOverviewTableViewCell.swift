//
//  SCAppointmentOverviewTableViewCell.swift
//  OSCA
//
//  Created by Rutvik Kanbargi on 16/07/20.
//  Copyright © 2020 Deutsche Telekom AG - VTI Organization. All rights reserved.
//

import UIKit

protocol SCAppointmentOverviewDataSourceCellDelegate: AnyObject {
    func deleteAppointment(at index: IndexPath, tableView: UITableView)
}

class SCAppointmentOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressDescLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!

    @IBOutlet weak var datePlaceholderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var appointmentStatusLabel: UILabel!
    @IBOutlet weak var appointmentStatusView: UIView!

    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var qrCodeButton: UIButton!
    @IBOutlet weak var buttonContainerView: UIView!

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var marginFillView: UIView!

    private weak var delegate: SCAppointmentOverviewDelegate?
    private var appointment: SCModelAppointment?
    private var shadowLayer: CAShapeLayer?
    
    private var deleteLabel: UILabel!
    private var pan: UIPanGestureRecognizer!

    private weak var dataSourceDelegate: SCAppointmentOverviewDataSourceCellDelegate?
    var indexPath: IndexPath?
    
    var deleteColor: UIColor {
        if (appointment?.endDate?.isHistoric() == true)
            || (appointment?.apptStatus == .rejected)
            || (appointment?.apptStatus == .cancellation) {
            return .appointmentRejected
        } else {
           return .gray
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        overlayView.alpha = 0.80
        shadowView.addShadow()
        containerView.addCornerRadius()

        qrCodeButton.setTitle(LocalizationKeys.SCAppointmentOverviewTableViewCell.apnmt002ShowQrCodeButton.localized(),
                              for: .normal)
        moreInfoButton.setTitle(LocalizationKeys.SCAppointmentOverviewTableViewCell.apnmt002MoreInfoButton.localized(),
        for: .normal)
        
        titleLabel.adaptFontSize()
        addressDescLabel.adaptFontSize()
        streetLabel.adaptFontSize()
        placeLabel.adaptFontSize()
        datePlaceholderLabel.adaptFontSize()
        dateLabel.adaptFontSize()
        timeLabel.adaptFontSize()
        moreInfoButton.titleLabel?.adaptFontSize()
        qrCodeButton.titleLabel?.adaptFontSize()

        deleteLabel = UILabel()
        deleteLabel.isAccessibilityElement = false
        deleteLabel.text = LocalizationKeys.SCAppointmentOverviewTableViewCell.b002InfoboxSwipedBtnDelete.localized()
        deleteLabel.textColor = UIColor.white
        deleteLabel.textAlignment = .left
        self.insertSubview(deleteLabel, belowSubview: self.contentView)

        deleteLabel.backgroundColor = deleteColor.withAlphaComponent(0.0)
        marginFillView.backgroundColor = deleteColor.withAlphaComponent(0.0)
        self.backgroundColor = .clear

        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
        
        let infoImage = moreInfoButton.imageView?.image?.maskWithColor(color: kColor_cityColor)
        let qrImage = qrCodeButton.imageView?.image?.maskWithColor(color: kColor_cityColor)
        moreInfoButton.setImage(infoImage, for: .normal)
        qrCodeButton.setImage(qrImage, for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        deleteLabel.isHidden = UIAccessibility.isVoiceOverRunning
        deleteLabel.isUserInteractionEnabled = UIAccessibility.isVoiceOverRunning

        if (pan.state == UIGestureRecognizer.State.changed) {
            if !isSwipeAllowed() {
                return
            }

            let point: CGPoint = pan.translation(in: self)
            let alpha = abs(point.x) / contentView.frame.width
            deleteLabel?.backgroundColor = deleteColor.withAlphaComponent(alpha)
            marginFillView.backgroundColor = deleteColor.withAlphaComponent(alpha)

            let width = self.contentView.frame.width
            let height = self.contentView.frame.height
            self.contentView.frame = CGRect(x: point.x,y: 0, width: width, height: height);
            self.deleteLabel?.frame = CGRect(x: point.x + width, y: 11, width: width, height: height - 22)
        } else {
            marginFillView.backgroundColor = deleteColor.withAlphaComponent(0.0)
            let width = self.contentView.frame.width
            let height = self.contentView.frame.height
            self.deleteLabel?.frame = CGRect(x: 0 + width, y: 11, width: width, height: height - 22)
            deleteLabel?.backgroundColor = deleteColor.withAlphaComponent(0.0)
        }
    }

    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if UIAccessibility.isVoiceOverRunning {
            return
        }
        if pan.state == UIGestureRecognizer.State.began {
        } else if pan.state == UIGestureRecognizer.State.changed {
            UIView.animate(withDuration: 0.2, animations: {
                self.setNeedsLayout()
            })
        } else {
            if abs(pan.velocity(in: self).x) > 500 && isSwipeAllowed() {
                let tableView = self.superview as! UITableView
                if let indexPath = tableView.indexPath(for: self) {
                    dataSourceDelegate?.deleteAppointment(at: indexPath, tableView: tableView)
                }
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
            }
        }
    }

    private func isSwipeAllowed() -> Bool {
        let point: CGPoint = pan.translation(in: self)
        if point.x > 0 {
            // Swipe from left to right not allowed
            return false
        } else {
            // Swipe from right to left allowed
            return true
        }
    }

    func set(appointment: SCModelAppointment, delegate: SCAppointmentOverviewDelegate?, dataSourceDelegate: SCAppointmentOverviewDataSourceCellDelegate, indexPath: IndexPath) {
        titleLabel.text = appointment.title
        addressDescLabel.text = appointment.addressDesc
        streetLabel.text = appointment.street
        placeLabel.text = appointment.place
        datePlaceholderLabel.text = LocalizationKeys.SCAppointmentOverviewTableViewCell.apnmt002DateLabel.localized()
        dateLabel.text = appointment.date
        timeLabel.text = appointment.time

        let statusConfig = appointment.apptStatus.getConfig(appointmentEndDate: appointment.endDate)
        appointmentStatusLabel.text = statusConfig.description
        appointmentStatusLabel.textColor = statusConfig.statusTextColor
        appointmentStatusView.backgroundColor = statusConfig.viewColor

        moreInfoButton.isUserInteractionEnabled = true
        qrCodeButton.isUserInteractionEnabled = statusConfig.isQRCodeAvailable
        qrCodeButton.alpha = statusConfig.isQRCodeAvailable ? 1.0 : 0.2
        overlayView.isHidden = statusConfig.isOverlayHidden
        self.appointment = appointment
        self.delegate = delegate
        self.dataSourceDelegate = dataSourceDelegate
        self.indexPath = indexPath
    }

    @IBAction func didTapOnMoreInfo(_ sender: UIButton) {
        guard let appointment = appointment else {
            return
        }
        delegate?.didSelected(appointment: appointment)
    }

    @IBAction func didTapOnQRCode(_ sender: UIButton) {
        guard let appointment = appointment else {
            return
        }
        delegate?.didTapOnQRCode(appointment: appointment)
    }
}

extension SCAppointmentOverviewTableViewCell {

    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
    }
}
