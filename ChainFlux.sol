// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ChainFlux Project Contract
 * @dev A simple smart contract with core project functions:
 *      - createTask
 *      - getTask
 *      - markCompleted
 */

contract Project {
    struct Task {
        string title;
        string description;
        bool completed;
    }

    Task[] public tasks;
    address public owner;

    event TaskCreated(uint256 taskId, string title);
    event TaskCompleted(uint256 taskId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Create a new task.
     */
    function createTask(string memory _title, string memory _description) public onlyOwner {
        tasks.push(Task(_title, _description, false));
        emit TaskCreated(tasks.length - 1, _title);
    }

    /**
     * @dev Retrieve a task by ID.
     */
    function getTask(uint256 _taskId) public view returns (string memory, string memory, bool) {
        require(_taskId < tasks.length, "Task does not exist");
        Task memory t = tasks[_taskId];
        return (t.title, t.description, t.completed);
    }

    /**
     * @dev Mark a task as completed.
     */
    function markCompleted(uint256 _taskId) public onlyOwner {
        require(_taskId < tasks.length, "Task does not exist");
        tasks[_taskId].completed = true;
        emit TaskCompleted(_taskId);
    }
}
