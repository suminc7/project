using UnityEngine;
using System.Collections;

public class MovingCubeController : MonoBehaviour {


	
	//LTSpline cr;
	private GameObject movingPoints;
	private GameObject currentCube;

	private int movingCount = 0;
	private int childCount;

	
	void OnEnable(){

	}
	
	void Start () {


		movingPoints = GameObject.Find ("MovingPoints");
		childCount = movingPoints.transform.childCount;

		for (int i = 0; i<childCount; i++) {
			movingPoints.transform.GetChild(i).gameObject.GetComponent<Renderer> ().enabled = false;
		}

		SetPosition ();

	}

	void Update () {

	}

	public void Moving(){
		//SetMovingCount ();
		movingCount++;
		SetPosition ();
	}

	//몬스터 죽일시 3초후 이동 
	public void ShowCurrentObject(){
		StartCoroutine(WaitAndPrint(3F));
	}

	IEnumerator WaitAndPrint(float waitTime) {

		yield return new WaitForSeconds(waitTime);
		currentCube.SetActive (true);
		currentCube.GetComponent<Collider> ().enabled = true;

	}




	void SetPosition (){

		if (childCount > movingCount) {
		
			GameObject cube = movingPoints.transform.GetChild(movingCount).gameObject;
			transform.position = cube.transform.position;
			transform.forward = cube.transform.forward;

			currentCube = cube;

		}
		
	}

}
