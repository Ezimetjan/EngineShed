//
//  ModelTableViewController.swift
//  EngineShed iOS
//
//  Created by Scott James Remnant on 9/17/18.
//  Copyright © 2018 Scott James Remnant. All rights reserved.
//

import UIKit
import CoreData

import Database

protocol ModelSettable : class {

    var model: Model? { get set }

}

class ModelTableViewController : UITableViewController {

    @IBOutlet weak var similarModelsButton: UIBarButtonItem!

    var persistentContainer: NSPersistentContainer?

    var model: Model? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Register for notifications of changes to the view context so we can update the view
        // when changes to the record are merged back into it.
        if let managedObjectContext = persistentContainer?.viewContext {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: managedObjectContext)
        }
    }

    func configureView() {
        // Update the view.
        tableView.reloadData()

        similarModelsButton.isEnabled = !(model?.similar().isEmpty ?? true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 10
        case 1: return 2
        case 2: return 12
        case 3: return 5
        case 4: return 3
        case 5: return 1
        default: preconditionFailure("Unexpected section: \(section)")
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String
        switch (indexPath.section, indexPath.row) {
        case (0, 0): identifier = "modelImage"
        case (0, 1): identifier = "modelPurchase"
        case (0, 2): identifier = "modelClassification"
        case (0, 3): identifier = "modelClass"
        case (0, 4): identifier = "modelNumber"
        case (0, 5): identifier = "modelName"
        case (0, 6): identifier = "modelLivery"
        case (0, 7): identifier = "modelDetails"
        case (0, 8): identifier = "modelEra"
        case (0, 9): identifier = "modelDisposition"
        // Electrical
        case (1, 0): identifier = "modelMotor"
        case (1, 1): identifier = "modelLights"
        // DCC
        case (2, 0): identifier = "modelSocket"
        case (2, 1): identifier = "modelDecoderType"
        case (2, 2): identifier = "modelDecoderSerialNumber"
        case (2, 3): identifier = "modelDecoderFirmwareVersion"
        case (2, 4): identifier = "modelDecoderFirmwareDate"
        case (2, 5): identifier = "modelDecoderAddress"
        case (2, 6): identifier = "modelDecoderSoundAuthor"
        case (2, 7): identifier = "modelDecoderSoundProject"
        case (2, 8): identifier = "modelDecoderSoundProjectVersion"
        case (2, 9): identifier = "modelDecoderSoundSettings"
        case (2, 10): identifier = "modelSpeaker"
        case (2, 11): identifier = "modelSpeakerFittings"
        // Details
        case (3, 0): identifier = "modelCouplings"
        case (3, 1): identifier = "modelFeatures"
        case (3, 2): identifier = "modelDetailParts"
        case (3, 3): identifier = "modelFittedDetailParts"
        case (3, 4): identifier = "modelModifications"
        // Maintenance
        case (4, 0): identifier = "modelLastRun"
        case (4, 1): identifier = "modelLastOil"
        case (4, 2): identifier = "modelTasks"
        // Notes
        case (5, 0): identifier = "modelNotes"

        default: preconditionFailure("Unexpected indexPath: \(indexPath)")
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UITableViewCell & ModelSettable
        cell.model = model
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return nil
        case 1: return "Electrical"
        case 2: return "DCC"
        case 3: return "Details"
        case 4: return "Maintenance"
        case 5: return "Notes"
        default: preconditionFailure("Unexpected section: \(section)")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modelPurchase" {
            let viewController = segue.destination as! PurchaseTableViewController
            viewController.persistentContainer = persistentContainer
            viewController.purchase = model?.purchase

        }
    }

    // MARK: - Notifications

    @objc
    func managedObjectContextObjectsDidChange(_ notification: Notification) {
        dispatchPrecondition(condition: .onQueue(DispatchQueue.main))
        guard let userInfo = notification.userInfo else { return }
        guard let model = model else { return }

        // Check for a refresh of our model object, by sync from cloud or merge after save
        // from other context, and reload the table.
        if let refreshedObjects = userInfo[NSRefreshedObjectsKey] as? Set<NSManagedObject>,
            refreshedObjects.contains(model)
        {
            tableView.reloadData()
        }

        // Check for a deletion of our model object, taking the view off the stack.
        if let deletedObjects = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>,
            deletedObjects.contains(model)
        {
            navigationController?.popViewController(animated: false)
        }
    }

}
