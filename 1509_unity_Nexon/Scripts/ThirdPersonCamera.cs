using UnityEngine;
using System.Collections;

public class ThirdPersonCamera : MonoBehaviour
{
	public float smooth = 0.1f;		// a public variable to adjust smoothing of camera motion
	Transform standardPos;			// the usual position for the camera, specified by a transform in the game
	Transform lookAtPos;			// the position to move the camera to when using head look
	Vector3 currentPos;

	public float speed = 5f;


	void Start()
	{

		
		if(GameObject.Find ("MovingCube"))
			lookAtPos = GameObject.Find ("MovingCube").transform;

		currentPos = transform.position;

	}
	
	void Update ()
	{

		Vector3 customPos = lookAtPos.position;
		customPos.y = transform.position.y;

		float step = speed * Time.deltaTime;
		transform.position = Vector3.MoveTowards(transform.position, customPos, step);

		//Debug.Log (transform.position);

		//Debug.Log (Time.deltaTime * smooth);
		//transform.position = Vector3.Lerp(currentPos, lookAtPos.position, smooth);



		//Vector3 vec = Vector3.Lerp(currentPos, lookAtPos.position, smooth);

		//smooth += 0.001f;
		//Debug.Log (lookAtPos.position.normalized);
		//transform.Translate(transform.position - vec);


		//transform.forward = lookAtPos.forward;
		/*
		else
		{	
			// return the camera to standard position and direction
			transform.position = Vector3.Lerp(transform.position, standardPos.position, Time.deltaTime * smooth);	
			transform.forward = Vector3.Lerp(transform.forward, standardPos.forward, Time.deltaTime * smooth);
		}
		*/
	}
}
